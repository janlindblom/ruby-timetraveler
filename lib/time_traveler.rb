require "time_traveler/version"
require "time_traveler/utils"
require "quadtree"
require "tzinfo"

# Find the time zone for a given geographical coordinate.
#
# @author Jan Lindblom <janlindblom@fastmail.fm>
module TimeTraveler
  # Find the timezone for a given set of coordinates.
  #
  # @param [Float] longitude the longitude.
  # @param [Float] latitude the latitude.
  # @return [TZInfo::Timezone] an object describing the timezone.
  def self.find_timezone(longitude, latitude)
    world = Utils.load_timezone_data
    entry_point = Quadtree::Point.new(longitude, latitude)
    radius = 6
    zones = []
    while zones.size == 0 or zones.size > 1
      points = world.query_range(Quadtree::AxisAlignedBoundingBox.new(entry_point, radius))
      zones = points.map { |p| TZInfo::Timezone.get(p.data) }.uniq
      radius -= 0.5
    end
    zones.first
  end

  private

  DATA_DIR = Pathname.new(__FILE__).join("../data").freeze
end
