require 'spec_helper'

#fix me kevin

describe Game do

 before(:each) do
   @league = FactoryGirl.create(:league)

   @teamstat_home = FactoryGirl.create(:teamstat, :league_id => @league.id)
    @teamstat_visiting = FactoryGirl.create(:teamstat, :league_id => @league.id)
    
    @person_home_1 = FactoryGirl.create(:person)
    @person_home_2 = FactoryGirl.create(:person)

    @person_visiting_1 = FactoryGirl.create(:person)
    @person_visiting_2 = FactoryGirl.create(:person)
    
    @created_by_id = 1
    @attr = { :league_id => @league.id, :teamstat1_id => @teamstat_visiting.id, :teamstat2_id => @teamstat_home.id, :created_by_id => @created_by_id, :updated_by_id => 1 }
  end

  it "should create a new instance given valid attributes" do
    Game.create!(@attr)
  end

  it "should validate visiting and home team are not the same id" do
    Game.new(@attr.merge(:teamstat1_id => 1, :teamstat2_id => 1)).should_not be_valid
  end

  it "should require created by id" do
    Game.new(@attr.merge(:created_by_id => nil)).should_not be_valid
  end

  it "should require updated by id" do
    Game.new(@attr.merge(:updated_by_id => nil)).should_not be_valid
  end

  describe "New games" do
    before(:each) do
      @game = Game.create(@attr)
    end
 
    it "should initialize goals to zero" do
      @game.home_team_goals.should == 0
      @game.visiting_team_goals.should == 0
    end
  end
  
  describe "game associations" do
    before(:each) do
      @game = Game.create!(@attr)

      #shouldn't we just mock playerstat here?
      @playerstat_1 = Playerstat.create!(:game_id => @game.id, :person_id => @person_home_1.id, :teamstat_id => @teamstat_home.id, :goals => 1, :created_by_id => @created_by_id, :updated_by_id => 1)
      @playerstat_2 = Playerstat.create!(:game_id => @game.id, :person_id => @person_home_2.id, :teamstat_id => @teamstat_home.id, :goals => 2, :created_by_id => @created_by_id, :updated_by_id => 1)
      @playerstat_3 = Playerstat.create!(:game_id => @game.id, :person_id => @person_visiting_1.id, :teamstat_id => @teamstat_visiting.id, :goals => 0, :created_by_id => @created_by_id, :updated_by_id => 1)
      @playerstat_4 = Playerstat.create!(:game_id => @game.id, :person_id => @person_visiting_2.id, :teamstat_id => @teamstat_visiting.id, :goals => 0, :created_by_id => @created_by_id, :updated_by_id => 1)

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
        @game.home_team.id.should == @teamstat_home.id
        @game.home_team.should == @teamstat_home

        @game.visiting_team.id.should == @teamstat_visiting.id
        @game.visiting_team.should == @teamstat_visiting
      end

      it "should have an associated playerstat aka roster" do
        #not sure I like this right now
        @game.playerstats[0].person.should == @person_home_1
        @game.playerstats[1].person.should == @person_home_2
        @game.playerstats[2].person.should == @person_visiting_1
        @game.playerstats[3].person.should == @person_visiting_2
      end
    end
  end
end