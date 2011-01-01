require 'spec_helper'

describe Playerstat do

 before(:each) do
    @team = Factory(:team)
    @game = Factory(:game)
    @player = Factory(:player)
    @attr = { :team_id => @team,
            :game_id => @game,
            :player_id => @player }
  end

  it "should have an user (update_by) field"

  it "should create a new instance given valid attributes" do
    Playerstat.create!(@attr)
  end  
  
  describe "validate associations" do

    before(:each) do
      @playerstat = Playerstat.create!(@attr)
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
      @playerstat.game_id.should == @game.id
      @playerstat.game.should == @game
    end

    it "should have the right associated team" do
      @playerstat.team_id.should == @team.id
      @playerstat.team.should == @team
    end
  end  
  
  describe "validations" do
    
    describe "success" do
      it "should accept content that is a number greater than or equal to zero" do
        Playerstat.new(@attr.merge(:jersey_number => "1")).should be_valid
        Playerstat.new(@attr.merge(:goals => "0")).should be_valid
        Playerstat.new(@attr.merge(:assists => "10")).should be_valid
        Playerstat.new(@attr.merge(:shots => "1000")).should be_valid
        Playerstat.new(@attr.merge(:fouls => "33")).should be_valid
        Playerstat.new(@attr.merge(:yellow_cards => "2")).should be_valid
        Playerstat.new(@attr.merge(:red_cards => "31")).should be_valid
        Playerstat.new(@attr.merge(:minutes => "222")).should be_valid
        Playerstat.new(@attr.merge(:saves => "23000")).should be_valid
      end
    end

    describe "failure" do
      it "should reject when keys are missing" do
        Playerstat.new(@attr.merge(:team_id => nil)).should_not be_valid
        Playerstat.new(@attr.merge(:game_id => nil)).should_not be_valid
        Playerstat.new(@attr.merge(:player_id => nil)).should_not be_valid
      end
      
      it "should reject non-numeric content and numbers less than zero" do
        Playerstat.new(@attr.merge(:jersey_number => "foo")).should_not be_valid
        Playerstat.new(@attr.merge(:goals => "-1")).should_not be_valid
        Playerstat.new(@attr.merge(:assists => "-33")).should_not be_valid
        Playerstat.new(@attr.merge(:shots => "foo")).should_not be_valid
        Playerstat.new(@attr.merge(:fouls => "foo")).should_not be_valid
        Playerstat.new(@attr.merge(:yellow_cards => "foo")).should_not be_valid
        Playerstat.new(@attr.merge(:red_cards => "foo")).should_not be_valid
        Playerstat.new(@attr.merge(:minutes => "foo")).should_not be_valid
        Playerstat.new(@attr.merge(:saves => "foo")).should_not be_valid        
      end
    end
    
  end  
  
end
