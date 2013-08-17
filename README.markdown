# Footy Stats

This is a Rails application designed to manage soccer leagues, specifically teams, players and their stats. 

### Features
You can add, update, and filter for these entities:
* Organizations (such as Federations or Associations)
* Leagues (anything from English Premier League to your local pub league)
* Teams
* People (Players, Referees, Coaches, and so on), with Avatar support via Amazon S3
* League Table Editing (without game magement)
* Roster Stats Editing (without game magement)
* Game Stat Management
* Venues (stadia or soccer complexes), with Google Maps API pinpoints

#### Two Ways to Manage Stats

This application also gives you the ability to manage stats in two ways: with or without game management. 

*Game Management*
A league configured with game management is intended for a league scorekeeper who needs to track stats closely at the game level. If you choose to manage your league with games (checkbox available on the League edit screen), you can track individual game statistics. The wins/losses/ties roll up to the league table. Game management still needs some work. Your mileage may vary.

*League Management*
A league configured without game management is intended for the casual fan or perhaps a pub (recreational) league administrator. Without game management, you may simply edit the league table. Additionally, this configuration also enables you to manage a player's stats for a season via the Roster edit screen.

### Contributions Welcome
This project is being continually improved. There is no official release yet. If you want to use it, feel free to fork it. Contributions are welcome. I have ideas for other features like favoriting a league (or any entity), image support for venues, and adding more roles to handle sharing/collaboration. There is a need to support import/export of data and reports, like a score card in game management. There is also a need for optimization. Work needs to done to ensure that we have enough database indexes, and queries are efficient.

### Getting Started
This is a Rails application. If you are new to Ruby or Rails, start [here](http://guides.rubyonrails.org). Currently, I run this on Ruby 2.0 with PostgreSQL as the database. See Gemfile for other dependency information.

### License
see LICENSE

### Why did you create this app?
I wanted to learn more Ruby and Rails. And, I love soccer. That's all the reason I need.
