RSpec.describe TimeTraveler::Utils do
  before :all do
    @download = false
    @unzip = false
    @processed = nil
    @restored = nil
  end

  it "can download data from geonames.org" do
    @download = TimeTraveler::Utils.download_geonames_data("cities15000", "tmp")
    expect(@download).to be true
  end

  it "can unzip downloaded data from geonames.org" do
    @unzip = TimeTraveler::Utils.unzip_geonames_data("cities15000", "tmp")
    expect(@unzip).to be true
  end

  it "can process unzipped data from geonames.org" do
    @processed = TimeTraveler::Utils.process_geonames_data("cities15000", "tmp", "tmp")
    expect(@processed).not_to be nil
  end

  it "can restore dumped data into a Quadtree" do
    @restored = TimeTraveler::Utils.load_timezone_data("tmp")
    expect(@restored).not_to be nil
  end
end
