[coconut_logo]: https://cloud.githubusercontent.com/assets/5973697/14249640/e8b278dc-fa37-11e5-9930-ee4e4e012918.png

# Coconut ![alt text][coconut_logo]
Local customer configuration switcher.

# Description
Coconut fetch the configuration files from development servers and stored them on a local folder. With those configuration files it can swap between different customers and prepare your local enviroment to start developing or testing locally.

## Installation
Execute the following script to install coconut

    $ ./install.sh

Check if coconut was succesfully installed:

    $ which cococonut

This command will install coconut in your system, and create a new folder in your $HOME folder, called .coconut, here is where all the configuration files like be stores. Coconut stores all those configuration on the customer folder, and indetify each customer with a .customer suffix.

```
/home/<you-user-name>/.coconut/
└── customer
   ├── file1.yml.customer1
   ├── file2.yml.customer2
   └── file3.yml.customer3

```

## Usage
In the project you will use coconut, you need to create a coconut configuration file called .coconut (not to be confused with the $HOME/.coconut folder). To create this file you need to run the following command.

```ruby
coconut init
```
## .coconut file

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
    $customer:
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

## Default attributes
In this customer section you can add default attibutes, to those will be overrriten when you swap the files into your project. This can be done for any file you like that coconut is swaping. See example below.

```yaml
server:
  ssh_user: user_name
  shared_folder: folder_path
  customers:
    customer1:
      address: ip_address
      file.yml:
        awesome_attribute: "attribute that needs to be changed"
      another file.yml:
        old_attribute: 42
```
## Rake tasks

Fetch configuration files from server. Files are stored in customers folder.

```ruby
coconut fetch $customer
```

Swap configuration to another customer. Caches will be cleared!


### Default attributes
In this customer section you can add default attibutes, to those will be overrriten when you swap the files into yout ```rur project. See example below.

```yaml

```
coconut swap $customer
```

## Warning

Be aware when you change sensitive files like database, you are going to be pointing to that server.
If you want to use a local dump. It's possible to create a local config file and swap to the local customer enviroment.
