# Coconut

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
