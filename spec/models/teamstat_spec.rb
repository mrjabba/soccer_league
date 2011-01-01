require 'spec_helper'

describe Teamstat do

  before(:each) do
    @league = Factory(:league)
    @team = Factory(:team)
    @attr = { :league_id => @league,
          :team_id => @team }
  end

  it "should have an user (update_by) field"

  it "should create a new instance given valid attributes" do
    Teamstat.create!(@attr)
  end

  describe "validate associations" do

    before(:each) do
      @teamstat = Teamstat.create!(@attr)
    end
      
    it "should have the right attributes" do
      @teamstat.should respond_to(:league)
      @teamstat.should respond_to(:team)
    end
  
    it "should have the right associated league" do
      @teamstat.league_id.should == @league.id
      @teamstat.league.should == @league
    end
  
    it "should have the right associated team" do
      @teamstat.team_id.should == @team.id
      @teamstat.team.should == @team
    end
  
  end

  describe "validations" do
    describe "success" do
      it "should accept content that is a number greater than or equal to zero" do
        Teamstat.new(@attr.merge(:wins => "1")).should be_valid
        Teamstat.new(@attr.merge(:losses => "5")).should be_valid
        Teamstat.new(@attr.merge(:ties => "12")).should be_valid
        Teamstat.new(@attr.merge(:goals_for => "0")).should be_valid
        Teamstat.new(@attr.merge(:goals_against => "1000")).should be_valid
     end
    end
    
    describe "failure" do
      it "should reject non-numeric content and numbers less than zero" do
        Teamstat.new(@attr.merge(:wins => "-1")).should_not be_valid
        Teamstat.new(@attr.merge(:losses => "foo")).should_not be_valid
        Teamstat.new(@attr.merge(:ties => "foo")).should_not be_valid
        Teamstat.new(@attr.merge(:goals_for => "foo")).should_not be_valid
        Teamstat.new(@attr.merge(:goals_against => "foo")).should_not be_valid
      end
      
      it "should require a league id" do
        Teamstat.new(@attr.merge(:league_id => nil)).should_not be_valid      
      end

      it "should require a team id" do
        Teamstat.new(@attr.merge(:team_id => nil)).should_not be_valid      
      end
    end
    
  end
  
  describe "calculations" do
    it "should calculate points" do
      Teamstat.new(@attr.merge(:wins => 3, :ties => 2)).points.should == 11
    end

    it "should calculate games played" do
      Teamstat.new(@attr.merge(:wins => 3, :losses => 2 , :ties => 1)).games_played.should == 6
    end
  end

end
