# Heimdall

An unobtrusive monitor using papertrail to gmail to ducksboard

## Installation

Add this line to your application's Gemfile:

    gem 'heimdall'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heimdall

## Usage

Start heimdall as a daemon

    ruby bin/run_heimdall.rb

Stop heimdall daemon

    ruby bin/run_heimdall.rb -k

## Contributing

1. Fork it ( http://github.com/<my-github-username>/heimdall/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
