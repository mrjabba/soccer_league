require 'spec_helper'

describe Roster do

  before(:each) do
    @teamstat = Factory(:teamstat)
    @player = Factory(:player)
    @attr = { :teamstat_id => @teamstat, :player_id => @player, :created_by_id => 1 }
  end

  it "should create a new instance given valid attributes" do
    Roster.create!(@attr)
  end

  it "should require a teamstat" do
    Roster.new(@attr.merge(:teamstat_id => "")).should_not be_valid
  end

  it "should require a player" do
    Roster.new(@attr.merge(:player_id => "")).should_not be_valid
  end

  it "should require created by id" do
    Roster.new(@attr.merge(:created_by_id => nil)).should_not be_valid
  end
end
