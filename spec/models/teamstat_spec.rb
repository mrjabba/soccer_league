require 'spec_helper'

describe Teamstat do

  before(:each) do
    @attr = {:wins => 1, :losses => 1, :ties => 1, :goals_for => 1, :goals_against => 1,
      :league_id => 1, :team_id => 1, :created_by_id => 1, :updated_by_id => 1}
  end

  describe "valid associations" do
    before(:each) do
      @league = FactoryGirl.create(:league)
      @team = FactoryGirl.create(:team)
      @teamstat = Teamstat.create!(:league_id => @league.id, :team_id => @team.id, :created_by_id => 1, :updated_by_id => 1)
    end

    it "should have the right associated league" do
      @teamstat.league_id.should == @league.id
      @teamstat.league.should == @league
    end
  
    it "should have the right associated team" do
      @teamstat.team_id.should == @team.id
      @teamstat.team.should == @team
    end

    it "should return only one teamstat when given a league and team" do
      Teamstat.teamstat_for_league(@league.id, @team.id).should == @teamstat
    end
  end

  describe "validations" do
      it "should be valid with valid attrs" do
        Teamstat.new(@attr).should be_valid
      end

      it "require wins be a number" do
        Teamstat.new(@attr.merge(:wins => "foo")).should_not be_valid
      end

      it "require wins be >=0" do
        Teamstat.new(@attr.merge(:wins => "-1")).should_not be_valid
      end

      it "require losses be a number" do
        Teamstat.new(@attr.merge(:losses => "foo")).should_not be_valid
      end

      it "require losses be >=0" do
        Teamstat.new(@attr.merge(:losses => "-5")).should_not be_valid
      end

      it "require ties be a number" do
        Teamstat.new(@attr.merge(:ties => "foo")).should_not be_valid
      end

      it "require ties be >=0" do
        Teamstat.new(@attr.merge(:ties => "-5")).should_not be_valid
      end

      it "require goals_for be a number" do
        Teamstat.new(@attr.merge(:goals_for => "foo")).should_not be_valid
      end

      it "require goals_for be >=0" do
        Teamstat.new(@attr.merge(:goals_for => "-4")).should_not be_valid
      end

      it "require goals_against be a number" do
        Teamstat.new(@attr.merge(:goals_against => "foo")).should_not be_valid
      end

      it "require goals_against be >=0" do
        Teamstat.new(@attr.merge(:goals_against => "-4")).should_not be_valid
      end
      
      it "should require a league id" do
        Teamstat.new(@attr.merge(:league_id => nil)).should_not be_valid
      end

      it "should require a team id" do
        Teamstat.new(@attr.merge(:team_id => nil)).should_not be_valid
      end

      it "should require created_by id" do
        Teamstat.new(@attr.merge(:created_by_id => nil)).should_not be_valid
      end

      it "should require updated_by id" do
        Teamstat.new(@attr.merge(:updated_by_id => nil)).should_not be_valid
      end
  end
  
  describe "calculations" do
    it "should calculate points" do
      @league = FactoryGirl.create(:league)
      @league.teamstats.build(@attr.merge(:wins => 3, :ties => 2)).calculate_points.should == 11
    end

    it "should calculate games played" do
      Teamstat.new(@attr.merge(:wins => 3, :losses => 2 , :ties => 1)).games_played.should == 6
    end

    it "should calculate when no games played" do
      Teamstat.new(@attr.merge(:wins => 0, :losses => 0 , :ties => nil)).games_played.should == 0
    end

    it "should sort league table sorted by points" do
      @league = FactoryGirl.create(:league)
      @team = FactoryGirl.create(:team)
      @teamstat_losers = Teamstat.create!(:league_id => @league.id, :team_id => @team.id, :created_by_id => 1, :updated_by_id => 1, :wins => 1, :losses => 1, :ties => 1)
      @teamstat_winners = Teamstat.create!(:league_id => @league.id, :team_id => @team.id, :created_by_id => 1, :updated_by_id => 1, :wins => 5, :losses => 0, :ties => 1)
      league_table = Teamstat.fetch_league_table(@league.id)
      league_table[0].wins.should eq(@teamstat_winners.wins)
    end
  end
end
