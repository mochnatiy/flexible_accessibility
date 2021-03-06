Flexible Accessibility

A simple library for setting access rules, based on analysis of current resources (e.g. controllers (with namespaces) and actions) that exists in application.

[![Code Climate](https://codeclimate.com/github/mochnatiy/flexible_accessibility.png)](https://codeclimate.com/github/mochnatiy/flexible_accessibility)

[![CircleCI](https://circleci.com/gh/mochnatiy/flexible_accessibility/tree/master.svg?style=svg)](https://circleci.com/gh/mochnatiy/flexible_accessibility/tree/master)

[![Gem Version](https://badge.fury.io/rb/flexible_accessibility.svg)](https://badge.fury.io/rb/flexible_accessibility)

Installation:

		gem install flexible_accessibility

  or add to your Gemfile

		gem 'flexible_accessibility', '~> 0.3.16'

  then do

            rails g flexible_accessibility:install

  to install migrations

Usage:

  All routes in application are closed by default
  To add route for check or open it you have to use 'authorize' macro in your controller
  The macro has a couple of options:

  Add all routes to check:

        authorize :all

  Add some routes to check but close all others

        authorize only: [:index, :new]

  Add all routes except :index to check, :index remains closed

        authorize except: [:index]

  Add :index and :new to check, skip (open) create for all

        authorize only: [:index, :new], skip: [:create]

  Open all routes for all

        authorize skip: :all

======================

# TODO: Review design
# TODO: Add tests

## Copyright
Copyright (c) 2012-2019 Sergei Avanesov
