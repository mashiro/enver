# Enver [![Build Status](https://travis-ci.org/mashiro/enver.png?branch=master)](https://travis-ci.org/mashiro/enver)

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
export SERVERS=4
```

```ruby
env = Enver.load do
  string :client_key, 'CLIENT_KEY'
  string :client_secret, 'CLIENT_SECRET'
  integer :servers, 'SERVERS'
  array :path, 'PATH', pattern: ':'
end

env.client_key # => 'xxx'
env.client_secret # => 'yyy'
env.servers # => 4
env.path # => array of your paths
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/enver/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
