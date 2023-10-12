# Terraform Beginner Bootcamp 2023 - week 1


### Working with Ruby 

#### Bundler

Bundler is a package manager for ruby. It is the primary way to intall ruby packages ( known as gems ) for ruby.

#### Install Gems

You need to create a Gemfile and define your Gems in that file .

```rb 
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command

This will install the gems on the system globally( unlike nodejs which install packages in place in a folder called node_modules

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in a tthe contect of bundler

We have to use ` bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

#### Sinatra 

Sinatra is a micro web framework for ruby to build web-apps .

Its great for mock or developement servers or for very simple projects.

you can create a web server ina a single file.

https://sinatrarb.com/

## Terratowns mock server

### running the we serber

We can run the web server by executing this follwoing commands

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.

## CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read Update, and Delete

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete