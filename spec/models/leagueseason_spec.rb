require 'spec_helper'

describe Leagueseason do

  before(:each) do
    @league = Factory(:league)
    @team = Factory(:team)
    @attr = { :team_id => @team }
  end

  it "should create a new instance given valid attributes" do
    @league.leagueseasons.create!(@attr)
  end

 describe "league associations" do

    before(:each) do
      @leagueseason = @league.leagueseasons.create(@attr)
    end
      
    it "should have a league attribute" do
      @leagueseason.should respond_to(:league)
    end
  
    it "should have the right associated league" do
      @leagueseason.league_id.should == @league.id
      @leagueseason.league.should == @league
    end
  
  end

  describe "validations" do
    it "should require a team id" do
      Leagueseason.new(@attr).should_not be_valid      
    end
    
  end

end
