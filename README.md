[coconut_logo]: https://cloud.githubusercontent.com/assets/5973697/14249640/e8b278dc-fa37-11e5-9930-ee4e4e012918.png

# Coconut ![alt text][coconut_logo]
D360 Local customer configuration switcher.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coconut', require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coconut

## Usage

Requires a configuration file called coconut.yml, placed in the config folder.

Run generator to create sample

```ruby
rails g coconut:install
```

## Rake tasks

Fetch configuration files from server. Files are stored in customers folder.

```ruby
rake coconut:fetch[$costumer]
```

Swap configuration to another customer. Caches will be cleared!

```ruby
rake coconut:swap[$costumer]
```
