#!/bin/bash

echo "Creating and populating database - do not shutdown!"
cd /workspace/doubtfire-api

bundle install
bundle exec rake db:populate
echo "Database created - you can open another terminal while this completes if you want.."

echo "Simulating sign off in the background - this may take a while.... but you can get started working - we are all setup"

bundle exec rake db:simulate_signoff >>/workspace/tmp/database_populate.log 2>>/workspace/tmp/database_populate.log
rm /workspace/tmp/database_populate.log

echo "Simulation of signoff complete"
