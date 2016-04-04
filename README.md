[coconut_logo]: https://cloud.githubusercontent.com/assets/5973697/14249640/e8b278dc-fa37-11e5-9930-ee4e4e012918.png

# Coconut ![alt text][coconut_logo]
D360 Local customer configuration switcher.

# Description
Coconut fetch the configuration files from dealer360 development servers and stored then on a local folder. With those configuration files it can swap between different customers and prepare your local enviroment to start developing.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coconut', require: false
```
Add this configuration to your application's Rakefile:

```ruby
Dealer360::Application.load_tasks

spec = Gem::Specification.find_by_name('coconut')
Dir["#{spec.gem_dir}/lib/tasks/**/*.rake"].each { |ext| load ext }
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
## Coconut.yml

The coconut file consists in 2 main sections, the local which has all local your local configurations and the server section which has all needed configuration to connect and fetch config files from the servers.

### customer_path
Folder in which the customer config files will be stored.

### config_files
Specific config files configuration, you can disable the swap functionality for any giving config file

### ssh_user
User that will be used to fetch the config files on the server

### shared_folder
Folder in which the config files are stored on the server. Example: /www/d360/shared/

### customers
Specific customers configurations that will be use to extract the information. Address is the IP address of those servers.
## Rake tasks

Fetch configuration files from server. Files are stored in customers folder.

```ruby
rake coconut:fetch[$costumer]
```

Swap configuration to another customer. Caches will be cleared!

```ruby
rake coconut:swap[$costumer]
```
