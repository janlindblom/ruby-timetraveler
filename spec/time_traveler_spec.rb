RSpec.describe TimeTraveler do
  it "has a version number", offline: true do
    expect(TimeTraveler::VERSION).not_to be nil
  end

  it "can find the timezone for Åland, Finland", offline: true do
    tz_geta = TimeTraveler.find_timezone(19.847005, 60.374794)
    expect(tz_geta).to be_a TZInfo::Timezone
    expect(tz_geta).to eq TZInfo::Timezone.get("Europe/Mariehamn")
  end

  it "can find the timezone for New Delhi, India", offline: true do
    tz_nd = TimeTraveler.find_timezone(77.2090210, 28.6139390)
    expect(tz_nd).to be_a TZInfo::Timezone
    expect(tz_nd).to eq TZInfo::Timezone.get("Asia/Kolkata")
  end

  it "can find the timezone for Palo Alto, USA", offline: true do
    tz_pa = TimeTraveler.find_timezone(-122.1430190, 37.4418830)
    expect(tz_pa).to be_a TZInfo::Timezone
    expect(tz_pa).to eq TZInfo::Timezone.get("America/Los_Angeles")
  end

  it "can find the timezone for Cape Town, South Africa", offline: true do
    tz_ct = TimeTraveler.find_timezone(18.4240550, -33.9248680)
    expect(tz_ct).to be_a TZInfo::Timezone
    expect(tz_ct).to eq TZInfo::Timezone.get("Africa/Johannesburg")
  end
end
