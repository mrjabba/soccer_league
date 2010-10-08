require 'spec_helper'

describe Teamstat do

  before(:each) do

    @league = Factory(:league)
    @team = Factory(:team)
    #@attr = { :team_id => @team }

    @attr = { :points => 5, :wins => 2, :losses => 1, 
          :ties => 1, :goals_for => 4, 
          :goals_against => 2, :games_played => 4 }
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
    
    it "should require non wins" do
      @league.teamstats.build(:wins => nil).should_not be_valid
    end
    
  end

end
