require 'time_traveler/utils'
City = Struct.new(:name, :latitude, :longitude, :timezone)

CITIES_FILE="cities15000"

# Geonames cities database: http://download.geonames.org/export/dump/cities5000.zip
namespace "metadata" do
  directory "tmp"
  directory "lib/data"

  task download: :tmp do |t|
    puts "Downloading #{CITIES_FILE}.zip from geonames.org..."
    TimeTraveler::Utils.download_geonames_data(CITIES_FILE, "./tmp")
    puts "Download finished. Stored as 'tmp/#{CITIES_FILE}.zip'."
  end

  task unzip: :download do |t|
    puts "Unzipping cities database from 'tmp/#{CITIES_FILE}.zip'..."
    TimeTraveler::Utils.unzip_geonames_data(CITIES_FILE, "./tmp")
    puts "Done."
  end

  task process: [:unzip, "lib/data"] do |t|
    TimeTraveler::Utils.process_geonames_data(CITIES_FILE, "./tmp")
  end

  task :clean do |t|
    rm_rf "tmp"
    rm_f "lib/data/cities.data"
  end

  desc "Update metadata from geonames.org"
  task update: [:tmp, :download, :unzip, :process] do |t|
  end
end
