# CapVagrant

Create a vagrant stage file for your capistrano deployment.

## Requirements

 * Capistrano
 * Capistrano Multistage Extension
 * Vagrant

## Installation

Add this line to your application's Gemfile in the same group as capistrano:

    gem 'cap_vagrant'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cap_vagrant

## Usage

Usage is pretty simple, just run `cap_vagrant` from the base directory of your project.  It will create a config/deploy/vagrant.rb file with the current output of `vagrant ssh-config`.  You can define the name of the stage by passing cap_vagrant a name option (EXE `cap_vagrant --name stage_name` or `cap_vagrant -n stage_name`)

You will have to add the stage to your deploy.rb file manually.
    
    $ set :stages, %w(production staging vagrant)

Then run `cap vagrant deploy:setup` or whatever your setup process is.

NOTE: When you reload a vagrant instance you might need to run `cap_vagrant -u` to update the port inforamation.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
