# Ceda Realty Website

This is the repository for the [Ceda Realty](http://cedarealty.com/) website app.

## Ruby Version

This application is intended to be run with Ruby 2.1.2.

## Rails Version

This application uses Rails 4.1.4.

## Local Development Installation

Clone the repository.

    $ git clone git@github.com:seaneshbaugh/ceda-realty.git

    $ cd ceda-realty

Install the necessary gems.

    $ bundle install

Create the databases.

    $ rake db:create

Add the database tables.

    $ rake db:migrate

Seed the database.

    $ rake db:seed_fu

## Tests

To run the test suite, after installing the gems, run the following command:

    $ rake test
