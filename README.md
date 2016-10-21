[coconut_logo]: https://cloud.githubusercontent.com/assets/5973697/14249640/e8b278dc-fa37-11e5-9930-ee4e4e012918.png

# Coconut ![alt text][coconut_logo]
Local customer configuration switcher.

# Description
Coconut fetch the configuration files from development servers and stored them on a local folder. With those configuration files it can swap between different customers and prepare your local enviroment to start developing or testing locally.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coconut', require: false
```
Add this configuration to your application's Rakefile:

```ruby
if Rails.env.development?
  spec = Gem::Specification.find_by_name('coconut')
  Dir["#{spec.gem_dir}/lib/tasks/**/*.rake"].each { |ext| load ext }
end
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

The coconut file consists in 2 main sections, the local which has all your local configurations and the server section which has all the needed configuration to connect and fetch config files from the servers.

```yaml
local:
  customer_path: customers
  config_files:
    file_name1.yml:
      swap: true
    file_name2.yml:
      swap: false

server:
  ssh_user: user_name
  shared_folder: folder_path
  customers:
    $costumer:
      address: ip_address
```

- customer_path
Folder in which the customer config files will be stored.

- config_files
Specific config files configuration, you can disable the swap functionality for any giving config file.

- ssh_user
User that will be used to fetch the config files on the server.

- shared_folder
Folder in which the config files are stored on the server.

- customers
Specific customers configurations that will be use to extract the information. Address is the IP address of those servers.
THe customer name can be any, not specifically the server name.

## Rake tasks

Fetch configuration files from server. Files are stored in customers folder.

```ruby
rake coconut:fetch[$costumer]
```

Swap configuration to another customer. Caches will be cleared!

```ruby
rake coconut:swap[$costumer]
```

## Warning

Be aware when you change sensitive files like database, you are going to be pointing to that server.
If you want to use a local dump. It's possible to create a local config file and swap to the local customer enviroment.
