require 'quadtree'

module TimeTraveler
  # Utilities for working with data files.
  #
  # @api private
  class Utils
    class << self

      # Load timezone database from file.
      #
      # @param [Pathname] working_directory
      # @return [Quadtree::Quadtree] the database.
      def load_timezone_data(working_directory=TimeTraveler::DATA_DIR)
        require 'json'
        Quadtree::Quadtree.from_json(JSON.load(unpack_timezone_data(working_directory)))
      end

      # @param [String] cities_file
      # @param [String] target_directory
      def download_geonames_data(cities_file, target_directory)
        require 'net/http'
        resp = nil
        Net::HTTP.start("download.geonames.org") do |http|
          resp = http.get("/export/dump/#{cities_file}.zip")
          open("#{target_directory}/#{cities_file}.zip", "wb") do |file|
            file.write(resp.body)
          end
        end
        !resp.nil? && resp.code.to_i < 400
      end

      # @param [String] cities_file
      # @param [String] working_directory
      def unzip_geonames_data(cities_file, working_directory)
        require 'zip'
        Zip.on_exists_proc = true
        extracted = nil
        extracted = Zip::File.open("#{working_directory}/#{cities_file}.zip") do |zip_file|
          zip_file.each do |entry|
            entry.extract("#{working_directory}/#{entry.name}")
          end
        end
        !extracted.nil? && extracted.size > 0
      end

      # @param [String] cities_file
      # @param [String] working_directory
      # @param [String] target_directory
      # @return [Quadtree::Quadtree] the database.
      def process_geonames_data(cities_file, working_directory, target_directory="./lib/data")
        require 'csv'

        aabb = Quadtree::AxisAlignedBoundingBox.new(Quadtree::Point.new(0,0), 180)
        qt = Quadtree::Quadtree.new(aabb)

        parsed_file = CSV.read("#{working_directory}/#{cities_file}.txt", { :col_sep => "\t" })
        parsed_file.each do |entry|
          if entry.size > 18
            latitude = entry[4]
            longitude = entry[5]
            timezone = entry[17]
            unless latitude.nil? or longitude.nil? or timezone.nil?
              point = Quadtree::Point.new(longitude.to_f, latitude.to_f, timezone)
              qt.insert! point
            end
          end
        end

        File.open("#{target_directory}/cities.data", 'w') do |f|
          f.write qt.to_json
        end

        pack_timezone_data(target_directory)

        qt
      end

      # @param [Pathname] working_directory
      def pack_timezone_data(working_directory=TimeTraveler::DATA_DIR)
        require 'zlib'
        working_directory = Pathname.new(working_directory) if working_directory.is_a? String

        Zlib::GzipWriter.open(working_directory.join("cities.data.gz")) do |gz|
          File.open(working_directory.join("cities.data")) do |fp|
            while chunk = fp.read(16 * 1024) do
              gz.write chunk
            end
          end
          gz.close
        end
      end

      # @param [Pathname] working_directory
      # @return [String]
      def unpack_timezone_data(working_directory=TimeTraveler::DATA_DIR)
        require 'zlib'
        working_directory = Pathname.new(working_directory) if working_directory.is_a? String
        gz = Zlib::GzipReader.open(working_directory.join("cities.data.gz"))
        gz.read
      end

    end
  end
end
