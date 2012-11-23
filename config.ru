# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
#run SoccerleagueApp::Application

require 'resque/server'
#TODO password protect resque here

run Rack::URLMap.new(
        '/' => SoccerleagueApp::Application,
        '/resque' => Resque::Server.new
    )
