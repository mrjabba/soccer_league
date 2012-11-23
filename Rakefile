# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'resque/tasks'

SoccerleagueApp::Application.load_tasks

#heroku resque
#https://devcenter.heroku.com/articles/queuing-ruby-resque
#start resque worker locally
#QUEUE=paperclip rake resque:work
task "resque:setup" => :environment do
  ENV['QUEUE'] ||= '*'
  #for redistogo on heroku http://stackoverflow.com/questions/2611747/rails-resque-workers-fail-with-pgerror-server-closed-the-connection-unexpectedl
  Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
end

