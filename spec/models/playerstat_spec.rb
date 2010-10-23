require 'spec_helper'

describe Playerstat do

 before(:each) do
    #@match = Factory(:match)
    @player = Factory(:player)
    @attr = { :goals => 1 }
    
  end

  it "should create a new instance given valid attributes" do
    @player.playerstats.create!(@attr)
  end  
  
  describe "player associations" do

    before(:each) do
      @playerstat = @player.playerstats.create(@attr)
    end

    it "should have a player attribute" do
      @playerstat.should respond_to(:player)
    end

    it "should have the right associated player" do
      @playerstat.player_id.should == @player.id
      @playerstat.player.should == @player
    end

    it "should have the right associated match" do
     # @playerstat.match_id.should == @match.id
     # @playerstat.match.should == @match
    end

  end  
  
  describe "validations" do
=begin
    it "should require a player id" do
      Playerstat.new(@attr).should_not be_valid      
    end
=end
    
    it "should require content" do
      @player.playerstats.build(:goals => nil).should_not be_valid
    end
=begin
    it "should reject non-numeric content" do
      @player.playerstats.build(:goals => "foo").should_not be_valid
    end
=end    
    
  end  
  
end
