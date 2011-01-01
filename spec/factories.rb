# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.username                  "Mr Greenjeans"
  user.email                 "greenjeans@foo.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
  user.roles                  [:admin]
end

Factory.sequence :username do |n|
  "user#{n}"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :player do |player|
  player.firstname                  "Fred"
  player.lastname                  "Flintstone"
  player.position                  "Midfielder"
  player.birth_date                  "09/22/1981"
  player.nationality                  "USA"
end

Factory.sequence :lastname do |n|
  "Van Playerson#{n}"
end

Factory.define :team do |team|
  team.name                  "Austin FC"
  team.address1                  "123 Main St."
  team.address2                  "Apt A"
  team.city                  "Austin"
  team.state                  "TX"
  team.zip                  "78704"
  team.phone                  "512-123-4567"
  team.website                  "http://foo.com"
  team.email                  "test@foo.com"
end

Factory.sequence :name do |n|
  "some Team FC-#{n}"
end

Factory.define :league do |league|
  league.year                 2002
  league.name                 "my soccer league"
end

Factory.define :teamstat do |teamstat|
#TODO can we turn off the stats for this since they are calculated on init now?
  teamstat.wins           0
  teamstat.losses         0
  teamstat.ties           0
  teamstat.goals_for      0
  teamstat.goals_against  0
  teamstat.games_played   0
  teamstat.team { |team|  team.association(:team, :name => Factory.next(:name)) }
  teamstat.league { |league|  league.association(:league) }
end

Factory.define :playerstat do |playerstat|
#TODO can we turn off the stats for this since they are calculated on init now?
  playerstat.goals           0
  playerstat.assists           0
  playerstat.shots           0
  playerstat.jersey_number           0
  playerstat.fouls           0
  playerstat.yellow_cards           0
  playerstat.red_cards           0
  playerstat.minutes           0
  playerstat.saves           0
  playerstat.player { |player|  player.association(:player) }
  playerstat.game { |game|  game.association(:game) }
  playerstat.team { |team|  team.association(:team) }
end


Factory.define :roster do |roster|
  roster.player { |player|  player.association(:player, :lastname => Factory.next(:lastname)) }
  #TODO should I do a Factory.next for teamstat factory objects?
  roster.teamstat { |teamstat|  teamstat.association(:teamstat) }
end

Factory.define :game do |game|
  game.league { |league|  league.association(:league) }
  game.visiting_team { |visiting_team|  visiting_team.association(:team, :name => Factory.next(:name))  }
  game.home_team { |home_team|  home_team.association(:team, :name => Factory.next(:name))  }
end
