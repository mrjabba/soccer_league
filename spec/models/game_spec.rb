require 'spec_helper'

#fix me kevin

describe Game do

 before(:each) do
    @league = Factory(:league)
    @user = Factory(:user, :email => Factory.next(:email))

    @teamstat_home = Factory(:teamstat, :league_id => @league.id)
    @teamstat_visiting = Factory(:teamstat, :league_id => @league.id)
    
    @player_home_1 = Factory(:player)
    @player_home_2 = Factory(:player)

    @player_visiting_1 = Factory(:player)
    @player_visiting_2 = Factory(:player)
    
    
    @attr = { :league_id => @league, :team1_id => @teamstat_visiting.team.id, :team2_id => @teamstat_home.team.id, :created_by_id => @user.id }

  end

  it "should validate visiting and home team are not the same id" do 
    game = Game.new(@attr.merge(:team1_id => 1, :team2_id => 1))
    game.should_not be_valid     
  end

  it "should have an user (update_by) field"

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

    describe "completed games" do

      it "should update league table (teamstats), home team wins" do
        #check_completed games. should be a better(more ruby-like) way to do this
        @teamstat_home.wins.should == 0
        @game.completed = true
        @game.save
        @teamstat_home = Teamstat.find_by_id(@teamstat_home.id)
        @teamstat_home.record.should == "1-0-0"
        @teamstat_visiting = Teamstat.find_by_id(@teamstat_visiting.id)
        @teamstat_visiting.record.should == "0-1-0"
      end

      it "should update league table (teamstats), visiting team wins" do
        #check_completed games. should be a better(more ruby-like) way to do this
        @playerstat_3.goals = 3
        @playerstat_3.save

        @playerstat_4.goals = 1
        @playerstat_4.save
        
        @teamstat_visiting.wins.should == 0
        @game.completed = true
        @game.save
        @teamstat_home = Teamstat.find_by_id(@teamstat_home.id)
        @teamstat_home.record.should == "0-1-0"
        @teamstat_visiting = Teamstat.find_by_id(@teamstat_visiting.id)
        @teamstat_visiting.record.should == "1-0-0"
      end


      it "should update league table (teamstats), tied game" do

        @playerstat_3.goals = 3
        @playerstat_3.save
        
        @game.completed = true
        @game.save

        @teamstat_home = Teamstat.find_by_id(@teamstat_home.id)
        @teamstat_home.record.should == "0-0-1"
        @teamstat_home.goals_for.should == 3
        @teamstat_home.goals_against.should == 3
        
        
        @teamstat_visiting = Teamstat.find_by_id(@teamstat_visiting.id)
        @teamstat_visiting.record.should == "0-0-1"
        @teamstat_visiting.goals_for.should == 3
        @teamstat_visiting.goals_against.should == 3
      end
    end

    describe "deleted games" do
      it "should revert game from league table (teamstats), home team win" do
        #check_completed games. should be a better(more ruby-like) way to do this
        @teamstat_home.wins.should == 0
        @game.completed = true
        @game.save
        @teamstat_home = Teamstat.find_by_id(@teamstat_home.id)
        @teamstat_home.wins.should == 1
        @game.destroy
        @teamstat_home = Teamstat.find_by_id(@teamstat_home.id)
        @teamstat_home.wins.should == 0
      end
      
      it "should revert game from league table (teamstats), visiting team win" do
        #check_completed games. should be a better(more ruby-like) way to do this
        @playerstat_3.goals = 5
        @playerstat_3.save
        
        @teamstat_visiting.wins.should == 0
        @game.completed = true
        @game.save
        @teamstat_visiting = Teamstat.find_by_id(@teamstat_visiting.id)
        @teamstat_visiting.wins.should == 1
        @game.destroy
        @teamstat_visiting = Teamstat.find_by_id(@teamstat_visiting.id)
        @teamstat_visiting.wins.should == 0
      end

      it "should revert game from league table (teamstats), teams tied" do
        #check_completed games. should be a better(more ruby-like) way to do this
        @playerstat_3.goals = 3
        @playerstat_3.save
        
        @teamstat_visiting.ties.should == 0
        @game.completed = true
        @game.save
        @teamstat_visiting = Teamstat.find_by_id(@teamstat_visiting.id)
        @teamstat_visiting.ties.should == 1
        @game.destroy
        @teamstat_visiting = Teamstat.find_by_id(@teamstat_visiting.id)
        @teamstat_visiting.ties.should == 0
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
