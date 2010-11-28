require 'spec_helper'

describe Game do

 before(:each) do
    @league = Factory(:league)

    @team_home = Factory(:team)
    @team_visiting = Factory(:team, :name => Factory.next(:name))

    @teamstat_home = Factory(:teamstat)
    @teamstat_visiting = Factory(:teamstat)

    @player_home_1 = Factory(:player)
    @player_home_2 = Factory(:player, :lastname => Factory.next(:lastname))
    
    @player_visiting_1 = Factory(:player, :lastname => Factory.next(:lastname))
    @player_visiting_2 = Factory(:player, :lastname => Factory.next(:lastname))
  end

  it "should create a new instance given valid attributes" do
    @game = @league.games.create(@attr)
    @game.home_team = @team_home
    @game.visiting_team = @team_visiting
    @game.league = @league
    @game.save
  end

  describe "game associations" do

    before(:each) do

      @game = Game.create()

      #assume we already have a league and 2 teams and just assign them 
      @game.league = @league
      @game.home_team = @team_home
      @game.visiting_team = @team_visiting
   
      #@game.playerstats.create(:player => @player)
      @playerstat_1 = Playerstat.new
      @playerstat_1.player = @player_home_1
      @playerstat_1.team = @team_home

      @playerstat_2 = Playerstat.new
      @playerstat_2.player = @player_home_2
      @playerstat_2.team = @team_home

      @playerstat_3 = Playerstat.new
      @playerstat_3.player = @player_visiting_1
      @playerstat_3.team = @team_visiting

      @playerstat_4 = Playerstat.new
      @playerstat_4.player = @player_visiting_2
      @playerstat_4.team = @team_visiting

      @game.playerstats[0] = @playerstat_1
      @game.playerstats[1] = @playerstat_2
      @game.playerstats[2] = @playerstat_3
      @game.playerstats[3] = @playerstat_4

    end
      
    it "should have the right attributes" do
      @game.should respond_to(:league)
      @game.should respond_to(:home_team)
      @game.should respond_to(:visiting_team)
      @game.should respond_to(:playerstats)
    end

    it "should have the right associated league" do
      @game.league_id.should == @league.id
      @game.league.should == @league
    end

    it "should have the right associated teams" do
      @game.team2_id.should == @team_home.id
      @game.home_team.should == @team_home

      @game.team1_id.should == @team_visiting.id
      @game.visiting_team.should == @team_visiting
    end

    it "should have an associated playerstat aka roster" do
      #not sure I like this right now
      @game.playerstats[0].player.should == @player_home_1
      @game.playerstats[1].player.should == @player_home_2
      @game.playerstats[2].player.should == @player_visiting_1
      @game.playerstats[3].player.should == @player_visiting_2
    end

    it "should mark completed" do
      @game.completed = false

      @game.game_completed=true
      
      @game.completed = true
      
      #TODO more to do here
    end
 
  end

end
