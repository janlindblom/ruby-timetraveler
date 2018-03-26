module TimeTraveler
  # @api private
  class Utils
    class << self

      def load_timezone_data(working_directory="lib/data")
        require 'quadtree'
        Marshal.load(unpack_timezone_data(working_directory))
      rescue
        nil
      end

      def pack_timezone_data(working_directory="lib/data")
        require 'zlib'
        Zlib::GzipWriter.open("#{working_directory}/cities.data.gz") do |gz|
          File.open("#{working_directory}/cities.data") do |fp|
            while chunk = fp.read(16 * 1024) do
              gz.write chunk
            end
          end
          gz.close
        end
        true
      rescue
        false
      end

      def unpack_timezone_data(working_directory="lib/data")
        require 'zlib'
        require 'quadtree'
        gz = Zlib::GzipReader.open("#{working_directory}/cities.data.gz")
        gz.read
      rescue
        nil
      end

      def download_geonames_data(cities_file, target_directory)
        require 'net/http'

        Net::HTTP.start("download.geonames.org") do |http|
          resp = http.get("/export/dump/#{cities_file}.zip")
          open("#{target_directory}/#{cities_file}.zip", "wb") do |file|
            file.write(resp.body)
          end
        end
        true
      rescue
        false
      end

      def unzip_geonames_data(cities_file, working_directory)
        require 'zip'
        Zip.on_exists_proc = true
        Zip::File.open("#{working_directory}/#{cities_file}.zip") do |zip_file|
          zip_file.each do |entry|
            entry.extract("#{working_directory}/#{entry.name}")
          end
        end
        true
      rescue
        false
      end

      def process_geonames_data(cities_file, working_directory, target_directory="lib/data")
        require 'csv'
        require 'quadtree'
        aabb = Quadtree::AxisAlignedBoundingBox.new(Quadtree::Point.new(0,0), 180)
        qt = Quadtree::Quadtree.new(aabb)

        parsed_file = CSV.read("#{working_directory}/#{cities_file}.txt", { :col_sep => "\t" })
        parsed_file.each do |entry|
          if entry.size > 18
            name = entry[1]
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
          f.write Marshal.dump(qt)
        end

        pack_timezone_data(target_directory)

        qt
      rescue
        nil
      end



    end
  end
end
