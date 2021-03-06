# Enver [![Build Status](https://travis-ci.org/mashiro/enver.svg)](https://travis-ci.org/mashiro/enver)

Minimal environment loader

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'enver'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enver

## Usage

```bash
export CLIENT_KEY=xxx
export CLIENT_SECRET=yyy
export NUM_SERVERS=4
export NEW_RELIC_LICENSE_KEY=lisencekey
export NEW_RELIC_APP_NAME=appname
```

```ruby
env = Enver.load do
  string :client_key
  string :client_secret
  integer :servers, 'NUM_SERVERS'
  array :path, pattern: ':'

  partial :new_relic do
    string :license_key
    string :app_name
  end
end

env.client_key # => 'xxx'
env.client_secret # => 'yyy'
env.servers # => 4
env.path # => array of your paths

env.new_relic.license_key # => 'licensekey'
env.new_relic.app_name # => 'appname'
```

## Contributing

1. Fork it ( https://github.com/mashiro/enver/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
