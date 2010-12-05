require 'spec_helper'

describe Game do

 before(:each) do
    @league = Factory(:league)

    @teamstat_home = Factory(:teamstat, :league_id => @league.id)
    @teamstat_visiting = Factory(:teamstat, :league_id => @league.id)
    
    @player_home_1 = Factory(:player)
    @player_home_2 = Factory(:player, :lastname => Factory.next(:lastname))
    
    @player_visiting_1 = Factory(:player, :lastname => Factory.next(:lastname))
    @player_visiting_2 = Factory(:player, :lastname => Factory.next(:lastname))
    
    @attr = { :league_id => @league, :team1_id => @teamstat_visiting.team.id, :team2_id => @teamstat_home.team.id }

  end

  it "should create a new instance given valid attributes" do
    Game.create!(@attr)
  end

  describe "New games " do

    before(:each) do
      @game = Game.create!(@attr)
    end
 
    it "should initialize goals to zero" do
      @game.home_team_goals.should == 0
      @game.visiting_team_goals.should == 0
    end

  end
  
  describe "game associations" do

    before(:each) do

      @game = Game.create!(@attr)

      @playerstat_1 = Playerstat.create!(:game_id => @game.id, :player_id => @player_home_1.id, :team_id => @teamstat_home.team.id, :goals => 1)
      @playerstat_2 = Playerstat.create!(:game_id => @game.id, :player_id => @player_home_2.id, :team_id => @teamstat_home.team.id, :goals => 2)
      @playerstat_3 = Playerstat.create!(:game_id => @game.id, :player_id => @player_visiting_1.id, :team_id => @teamstat_visiting.team.id, :goals => 0)
      @playerstat_4 = Playerstat.create!(:game_id => @game.id, :player_id => @player_visiting_2.id, :team_id => @teamstat_visiting.team.id, :goals => 0)

      #refresh game to get playerstats (better way to do this?)
      @game = Game.find_by_id(@game.id)

    end

    it "should have the right attributes" do
      @game.should respond_to(:league)
      @game.should respond_to(:home_team)
      @game.should respond_to(:visiting_team)
      @game.should respond_to(:playerstats)
    end

    describe "completed games" do
      it "should handle changes league table (teamstats) upon game completion" do
        #check_completed games. should be a better(more ruby-like) way to do this
        @teamstat_home.wins.should == 0
        @game.completed = true
        @game.save
        @teamstat_home = Teamstat.find_by_id(@teamstat_home.id)
        @teamstat_home.wins.should == 1
      end
    end

    describe "in-progress games" do

      it "should calculate goals when playerstats are changed" do
        @game.visiting_team_goals.should == 0
        @game.home_team_goals.should == 3
      end

      it "should have the right associated league" do
        @game.league_id.should == @league.id
        @game.league.should == @league
      end

      it "should have the right associated teams" do
        @game.home_team.id.should == @teamstat_home.team.id
        @game.home_team.should == @teamstat_home.team

        @game.visiting_team.id.should == @teamstat_visiting.team.id
        @game.visiting_team.should == @teamstat_visiting.team
      end

      it "should have an associated playerstat aka roster" do
        #not sure I like this right now
        @game.playerstats[0].player.should == @player_home_1
        @game.playerstats[1].player.should == @player_home_2
        @game.playerstats[2].player.should == @player_visiting_1
        @game.playerstats[3].player.should == @player_visiting_2
      end

    end
 
  end

end
