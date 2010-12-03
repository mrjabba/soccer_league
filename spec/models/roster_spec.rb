require 'spec_helper'

describe Roster do

  before(:each) do
    @teamstat = Factory(:teamstat)
    @player = Factory(:player)
    @attr = { :teamstat_id => @teamstat, :player_id => @player } 
  end

  it "should create a new instance given valid attributes" do
    Roster.create!(@attr)
  end

  it "should require a teamstat" do
    no_teamstat_roster = Roster.new(@attr.merge(:teamstat_id => ""))
    no_teamstat_roster.should_not be_valid
  end


  it "should require a player" do
    no_player_roster = Roster.new(@attr.merge(:player_id => ""))
    no_player_roster.should_not be_valid
  end

  describe "roster associations" do

    before(:each) do
      @roster = Roster.create()
    end

    it "should have the right attributes" do
      @roster.should respond_to(:player)
      @roster.should respond_to(:teamstat)
    end
    
  end

end
