require 'spec_helper'

describe Roster do

  before(:each) do
    @teamstat = Factory(:teamstat)
    @player = Factory(:player)
  end

  it "should create a new instance given valid attributes" do
    @roster = Roster.create!(@attr)
    @roster.teamstat = @teamstat
    @roster.player = @player
    @roster.save
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
