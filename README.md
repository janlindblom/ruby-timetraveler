# TimeTraveler

TimeTraveler finds timezones based on geographical coordinates using offline
data and Quadtree lookups intead of an online API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tz-traveler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tz-traveler

## Usage

Find a timezone for a geographical coordinate (WGS84) like so:

```ruby
require 'time_traveler'

TimeTraveler.find_timezone(77.2090210, 28.6139390)
```

## How it Works

The TimeTraveler gem contains a rather large blob which is in reality a JSON document describing a full Quadtree with all the cities contained in the GeoNames "Free Gazetteer extract" file `cities15000.zip` which contains "cities with a population > 15000 or capitals (ca 25.000)".

The Quadtree datastructure contains only the WGS84 coordinates and the IANA timezone for each city, so that it's really just big set of time zones at different places on the earth.

This Quadtree can be rebuilt periodically from the latest version available from GeoNames.

The `cities15000.zip` file is downloaded from GeoNames [Free Gazetteer Data](http://download.geonames.org/export/dump/) where it is made available under a [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/) License.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on Bitbucket at <https://github.com/janlindblom/ruby-timetraveler>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

Geographical data from the GeoNames Free Gazetteer extract `cities15000.zip` file is used under the [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/) License.

The embedded JSON data structure contained in the TimeTraveler gem constructed from this data is to be considered an adapted work in accordance with this license.

## Code of Conduct

Everyone interacting in the TimezoneCalculator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/janlindblom/ruby-timetraveler/blob/main/CODE_OF_CONDUCT.md).
