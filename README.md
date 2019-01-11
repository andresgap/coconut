[coconut_logo]: https://cloud.githubusercontent.com/assets/5973697/14249640/e8b278dc-fa37-11e5-9930-ee4e4e012918.png

# Coconut ![alt text][coconut_logo]
Local customer configuration switcher.

# Description
Coconut fetches the configuration files from development servers and stored them on a local folder. With those configuration files, it can swap between different customers and prepare your local environment to start developing or testing locally.

# Table Of Contents

* [Installation](#installation)
* [FAQs](#faqs)
* [Usage](#usage)
    * [Create an Instance](#create-an-instance)
    * [Getting Files](#getting-files)
    * [Swapping The Files](#swapping-the-files)
* [Configuration File](#configuration-file)
    * [Local section](#local-section)
    * [Server section](#server-section)
        * [Default attributes](#default-attributes)
        * [General Attributes](#general-attributes)
        * [Dynamic Customers](#dynamic-customers)
* [Commands](#commands)
* [Warning](#warning)

## Installation
Execute the following script to install coconut

    $ ./install.sh

Check if coconut was successfully installed:

    $ which coconut

This command will install coconut in your system, and create a new folder in your $HOME folder, called .coconut, here is where all the configuration files like be stores. Coconut stores all those configurations on the customer folder, and identify each customer with a .customer suffix.

```
/home/<you-user-name>/.coconut/
└── customer
   ├── file1.yml.customer1
   ├── file2.yml.customer2
   └── file3.yml.customer3

```

## FAQs

#### What is a Customer?

A customer is a representation of a remote server to `fetch` the files. The customers are configured on the .coconut file or are dynamically created in the `fetch` process by coconut by using the param send on the fetch command.

#### Can I use coconut in any rails application?

Coconut is not attached to any Rails application. Coconut is a gem created to fetch and swap file for

#### What is a .coconut file?

.coconut is a configuration file that set the behavior of how coconut will behave. This file is created when a new instance of coconut is created on a folder with the command `coconut init`. To understand more about .coconut please check the [.coconut documentation](#configuration-file)

#### Can I fetch folder or folder structures from the server?

No, coconut was created to quickly fetch configuration files from a remote server. Not to fetch complete server structures.

#### How do I fetch any files from the server?
Yes, you could fetch any file located on a server. You just need to specify the file name on the `local` section and the path to fetch those files on the `shared_folder` attribute of the `server` section of the `.coconut` file.

If you don't want to affect the rails application that you are currently using coconut you could always create a new folder with a new coconut instance.

#### Where are all the files saved?

All the files are saved on the $HOME/.coconut/customer folder, this folder is created during the installation process.

#### The installation process failed because of a permission denied process. What can I do?

Part of the installation script is to run `coconut install`. This created a folder on your $HOME folder called $HOME/.coconut/customer is which all the coconut configuration are saved. If the installation process fails for this probably is because coconut wasn't able to create this folder, you could manually create the folders, and then continue using coconuts normally.


#### I have an older version, how can I upload to the latest version?

Fetch the latest version of the repository using git and then rerun a `./install.sh`. This will remove the previous version of coconut and install the latest version.

#### I have two versions of coconut, but I can not run the one I want?

You can run a `gem uninstall coconut` and this will make you choose which is the version you want to remove.

## Usage
In the project you will use coconut, you need to create a coconut configuration file called .coconut (not to be confused with the $HOME/.coconut folder that is the global configuration folder). To create this file you need to run the following command.

### Create an Instance
```ruby
coconut init
```
Coconut init will run a ask you several questions to help you initialize your coconut instance.

```
~/Projects/rails_project$ coconut init
Generating .coconut configuration file

Set your SSH user: <set your ssh user>
Set shared_folder path (server path): <path of the files that are being fetched>
Set the server prefix: <prefix of the user to be used by the dynamic customers>
Set the server suffix: <suffix of the user to be used by the dynamic customers>
      create  .coconut
```

### Getting files

After, initializing your coconut instance you will like to fetch some file from the server. For doing this you will like to configure your .coconut files. Set the files that you will like to fetch on the local section of your coconut file.

```yaml
local:
  config_files:
    filename:
      swap: true
    filename2:
      swap: false
    filename3:
      swap: true
```

After data, set the customer you will like to fetch the information from.

```
server:
  ssh_user: < ssh user >
  shared_folder: < path of the files that are being fetch>
  prefix: < server-prefix >
  suffix: < server-suffix >
  customers:
    customer-key:
      address: <ip_address or hostname>
```

Then your coconut file is properly set, know you can use the coconut fetch command to get your new files. This files will be saved on $HOME/.coconut/customer folder.

```
coconut fetch customer-key
```

### Swapping the files

After, you fetch the files. You are ready to swap the files to your local environment. Just run the `coconut swap` command.

```
  coconut swap customer-key
```

## Configuration File

The coconut file consists of 2 main sections, the local which has all your local configurations and the server section which has all the needed configuration to connect and fetch config files from the servers.

```yaml
local:
  config_files:
    filename:
      swap: true
    filename2:
      swap: false
    filename3:
      swap: true

server:
  ssh_user: < ssh user >
  shared_folder: < path of the files that are being fetch>
  prefix: < server-prefix >
  suffix: < server-suffix >
  customers:
    customer-key:
      address: <ip_address>
```

### Local section

**- config_files**

This section is to set the files that will be fetched by the `coconut fetch` command. But also you can control which files will be swap to your current environment by enabling or disabling the swap parameter of the file. For example, if you want to swap a bunch of files but not to change your database configuration you can set you database.yml to false and swap the other files.

```
filename:
  swap: true
filename2:
  swap: false
```

If the swap command fails, could be that there is a file that has not been fetch, try to fetch all the files again and then try the `coconut swap` command again.

### Server section

**- ssh_user**
The user that will be used to fetch the config files on the server.

**- shared_folder**
The folder in which the config files are stored on the server. This could be any folder on the //server.

**- prefix**
The prefix of the hostname used by the dynamic customers. For more information click [here](#dynamic-customers)

**- suffix**
The prefix of the hostname used by the dynamic customers. For more information click [here](#dynamic-customers)

**- customers**
Specific customers configurations that will be used to extract the information. Address is the IP address or a hostname of those servers. The customer name can be any, not specifically the server name.

### Default attributes
In this customer section, you can add default attributes, to those will be overwritten when you fetch the files into your project. This can be done for any file you like that coconut is fetching. See the example below.

```yaml
server:
  ...
  ...
  customers:
    customer1:
      address: ip_address
      file.yml:
        awesome_attribute: "attribute that needs to be changed"
      another file.yml:
        old_attribute: 42
```
### General Attributes

You can also set the general configuration for all your customers. For example, let's say that you need to set a timeout for all the database connections, so instead of setting this for all customers, you could just create a general default attributes for all tenants. This is done by creating a customer named general on the customer's section and add the values you will like to set.

```yaml
server:
  ...
  ...
  customers:
    general:
      file.yml:
        awesome_attribute: "attribute that needs to be changed"
      another file.yml:
        old_attribute: 42
```

### Dynamic Customers

If you feel lazy and you don't want to set all the customer you could fetch configuration files. You could use the dynamic customer feature. The dynamic customer is a feature to let the `coconut fetch` command which server it need to extract the files from. This feature will fetch the server using this naming convention for the hostname `{PREFIX}-{CUSTOMER}-{ENVIROMENT}-{SUFFIX}`. For this, you need to configure your server prefix and the suffix `.coconut` file.

```yaml
server:
  ...
  ...
  prefix: < server-prefix >
  suffix: < server-suffix >
  ...
  ...
```

**Who is the environment detected?**

The environment is detected by the customer name you are sending to `coconut fetch` command. If you send just the customer name. It will assume it a development environment. Let's say that you have wanted to access a server named `{PREFIX}-omega-dev-{SUFFIX}` so you could use the fetch command in the following way.

```
coconut fetch omega
# {PREFIX}-{omega}-{dev}-{SUFFIX}
```

## Commands

**-install**
Install the coconut in the local environment. Creating the folder $HOME/.coconut/customer. If this command fails checks the following information [here](#the-installation-process-failed-because-of-a-permission-denied-process-what-can-i-do).

```ruby
coconut install
```

**-init**
Init a folder with a coconut instance, creating the .coconut file and letting know to coconut that there is already a coconut instance on that folder. This will run a wizard on the console to help you complete your `.coconut` file. For more information check the following information [here](#configuration-file).

```ruby
coconut init
```

**- fetch:**
Fetch configuration files from a server. Based customers configure the server section of your `.coconut` file. Or by using dynamic customer based on the prefix and suffix configure on the server section. Files are stored in customers folder. For more information check the following information [here](#getting-files).

```ruby
coconut fetch $customer
```

**- swap:**

Swap configuration to another customer. Based on the files marked as swap on the local section of your `.coconut` file. Caches will be cleared! For more information check the following information [here](#swapping-the-files).

```ruby
coconut swap $customer
```

**-version**

Display the current version of coconut.

```
coconut version
```

**help**

Displays all the command and provides useful information of the coconut commands.

```
coconut help
```

or

```ruby
coconut help $command
```

## Warning

Be aware when you change sensitive files like a database, you are going to be pointing to that server.
If you want to use a local dump. It's possible to create a local config file and swap to the local customer environment.
