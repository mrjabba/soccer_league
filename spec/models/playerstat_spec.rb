require 'spec_helper'

describe Playerstat do

 before(:each) do
    #@game = Factory(:game)
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

    it "should have the right attributes" do
      @playerstat.should respond_to(:player)
      @playerstat.should respond_to(:game)
      @playerstat.should respond_to(:team)
    end

    it "should have the right associated player" do
      @playerstat.player_id.should == @player.id
      @playerstat.player.should == @player
    end

    it "should have the right associated game" do
     # @playerstat.game_id.should == @game.id
     # @playerstat.game.should == @game
    end

  end  
  
  describe "validations" do
=begin
    it "should require a player id" do
      Playerstat.new(@attr).should_not be_valid      
    end
=end
    
=begin
    it "should reject non-numeric content" do
      @player.playerstats.build(:goals => "foo").should_not be_valid
    end
=end    
    
  end  
  
end
