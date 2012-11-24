# Footy Stats

This is a Rails application designed to manage soccer leagues, specifically teams, players and their stats. 

### Features
You can add, update, and filter for these entities:
* Organizations (such as Federations or Associations)
* Leagues (anything from English Premier League to your local pub league)
* Teams
* People (Players, Referees, Coaches, and so on), with Avatar support via Amazon S3
* League Table Editing
* Game Stat Management
* Venues (stadia or soccer complexes), with Google Maps API pinpoints

This application also gives you the ability to manage stats. You can configure a league to manage games where league tables are automatically updated from those games. Or, you can choose a simpler approach without game management. This will allow you to simply edit the league table.Game management still needs some work. Your mileage may vary.

This project is being continually improved. There is no official release yet. If you want to use it, feel free to fork it. Contributions are welcome. I have ideas for other features like favoriting a league (or any entity), image support for venues, and adding more roles to handle sharing/collaboration. There is a need to support import/export of data and reports, like a score card in game management. There is also a need for optimization. Work needs to done to ensure that we have enough database indexes, and queries are efficient.

### Getting Started
This is a Rails application. If you are new to Ruby or Rails, start [here](http://guides.rubyonrails.org). Currently, I run this on Ruby 1.9.2 with PostgreSQL as the database. See Gemfile for other dependency information.

### License
see LICENSE

### Why did you create this app?
I wanted to learn more Ruby and Rails. And, I love soccer. That's all the reason I need.
