require 'spec_helper'

describe Teamstat do

  before(:each) do

    @league = Factory(:league)
    @team = Factory(:team)

    @attr = { :wins => 2, :losses => 1, 
          :ties => 1, :goals_for => 4, 
          :goals_against => 2 }
          #, :team_id => @team
  end


  it "should create a new instance given valid attributes" do
    #@league.teamstats.create!(@attr)
    @teamstat = @league.teamstats.create(@attr)
    @teamstat.team = @team
    @teamstat.save
    #TODO is there a 1 line way to do this?
  end

  describe "league associations" do

    before(:each) do
      @teamstat = @league.teamstats.create(@attr)
    end
      
    it "should have a league attribute" do
      @teamstat.should respond_to(:league)
    end
  
    it "should have the right associated league" do
      @teamstat.league_id.should == @league.id
      @teamstat.league.should == @league
    end
  
  end

  describe "validations" do
    it "should require a league id" do
      Teamstat.new(@attr).should_not be_valid      
    end
    
    it "should require wins" do
      @league.teamstats.build(@attr.merge(:wins => nil)).should_not be_valid
    end

    it "should require losses" do
      @league.teamstats.build(@attr.merge(:losses => nil)).should_not be_valid
    end

    it "should require ties" do
      @league.teamstats.build(@attr.merge(:ties => nil)).should_not be_valid
    end

    it "should require goals_for" do
      @league.teamstats.build(@attr.merge(:goals_for => nil)).should_not be_valid
    end

    it "should require goals_against" do
      @league.teamstats.build(@attr.merge(:goals_against => nil)).should_not be_valid
    end

    it "should require games_played" do
      @league.teamstats.build(@attr.merge(:games_played => nil)).should_not be_valid
    end

    it "should calculate points" do
      @league.teamstats.build(@attr.merge(:wins => 3, :ties => 2))
      @league.teamstats[0].points.should == 11
    end

    it "should calculate games played" do
      @league.teamstats.build(@attr.merge(:wins => 3, :losses => 2, :ties => 1))
      @league.teamstats[0].games_played.should == 6
    end
    
  end

end
