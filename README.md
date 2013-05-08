# LiveResource::Pubnub

Provides LiveResource integration with Pubnub.

## Installation

Add this line to your application's Gemfile:

    gem 'live_resource-pubnub'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install live_resource-pubnub

## Usage

Instantiate and supply a PubnubProtocol to the LiveResource::Builder.

## Rails

(Requires [live_resource-rails](http://github.com/live-resource/rails)

```ruby
# application.rb

...

config.live_resource[:protocol] = LiveResource::Pubnub::PubnubProtocol.new(
  Pubnub.new(
    publish_key:   Education::Application.config.pubnub[:publish_key],
    subscribe_key: Education::Application.config.pubnub[:subscribe_key],
    secret_key:    Education::Application.config.pubnub[:secret_key],
    cipher_key:    Education::Application.config.pubnub[:cipher_key],
    ssl:           false
  ))
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
