# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :player do |player|
  player.firstname                  "Fred"
  player.lastname                  "Flintstone"
  player.position                  "Midfielder"
  player.jersey_number                  10
  player.birth_date                  "09/22/1981"
  player.nationality                  "USA"
  player.previous_club                  "Some Other Club"
end

Factory.define :team do |team|
  team.name                  "Aztex"
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

Factory.define :leagueseason do |leagueseason|
  leagueseason.association  :league
  leagueseason.association  :team
end
=begin
  @leaguetmp = Factory(:league)
  @teamtmp = Factory(:team)
  leagueseason.league_id                 @leaguetmp
  leagueseason.team_id                 @teamtmp  
=end

