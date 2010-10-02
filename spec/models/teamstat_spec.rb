require 'spec_helper'

describe Teamstat do

  before(:each) do

    #@league = Factory(:league)
    #@team = Factory(:team, :name => "my team")
    @leagueseason = Factory(:leagueseason)
    @attr = { :points => 5, :wins => 2, :losses => 1, 
          :ties => 1, :goals_for => 4, 
          :goals_against => 2, :games_played => 4 }
    
=begin
    @attr = { :team_id => @team }
#    @attr = { :league_season_id => @leagueseason }
    @leagueseason = @league.leagueseasons.create(@attr)

    @league = Factory(:league)
    @team = Factory(:team)
    @attr = { :team_id => @team }
#    @attr = { :league_season_id => @leagueseason }
#    @leagueseason = Factory(:leagueseason)
    @leagueseason = @league.leagueseasons.create(@attr)



  @leaguetmp = Factory(:league)
  @teamtmp = Factory(:team)
  leagueseason.league_id                 @leaguetmp
  leagueseason.team_id                 @teamtmp  
=end    
    
  end


  it "should create a new instance given valid attributes" do
    @leagueseason.teamstats.create!(@attr)
  end

  describe "leagueseason associations" do

    before(:each) do
      @teamstat = @leagueseason.teamstats.create(@attr)
    end
      
    it "should have a leagueseason attribute" do
      @teamstat.should respond_to(:leagueseason)
    end
  
    it "should have the right associated leagueseason" do
      @teamstat.leagueseason_id.should == @leagueseason.id
      @teamstat.leagueseason.should == @leagueseason
    end
  
  end

  describe "validations" do
    it "should require a leagueseason id" do
      Teamstat.new(@attr).should_not be_valid      
    end
    
    it "should require non wins" do
      @leagueseason.teamstats.build(:wins => nil).should_not be_valid
    end
    
  end

end
