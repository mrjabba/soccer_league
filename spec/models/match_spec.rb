require 'spec_helper'

describe Match do

 before(:each) do
    @league = Factory(:league)

    #need to create 2 teams, so you have to vary the attr's?
    @team_home = Factory(:team)
    @team_visiting = Factory(:team, :name => Factory.next(:name))

    #@player = Factory(:player)
    #@attr = { :goals => 1 }
    #create a bunch of player_stats (should default to zero)
    
  end

  it "should create a new instance given valid attributes" do
    @match = @league.matches.create(@attr)
    @match.home_team = @team_home
    @match.visiting_team = @team_visiting
    @match.save
  end

  describe "match associations" do

    before(:each) do
      @match = @league.matches.create(@attr)
      @match.home_team = @team_home
      @match.visiting_team = @team_visiting
    end
      
    it "should have the right attributes" do
      @match.should respond_to(:league)
      @match.should respond_to(:home_team)
      @match.should respond_to(:visiting_team)
    end

    it "should have the right associated league" do
      @match.league_id.should == @league.id
      @match.league.should == @league
    end

    it "should have the right associated teams" do
      @match.team2_id.should == @team_home.id
      @match.home_team.should == @team_home

      @match.team1_id.should == @team_visiting.id
      @match.visiting_team.should == @team_visiting
    end


  end

end
