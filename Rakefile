require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'net/http'
require 'zip'
require 'fileutils'

# Geonames cities database: http://download.geonames.org/export/dump/cities15000.zip

task :update_metadata do |t|
    FileUtils::mkdir_p 'tmp'
    Net::HTTP.start("download.geonames.org") do |http|
        resp = http.get("/export/dump/cities15000.zip")
        open("tmp/cities15000.zip", "wb") do |file|
            file.write(resp.body)
        end
    end
end


RSpec::Core::RakeTask.new(:spec)

task :default => :spec
