require 'spec_helper'

describe Playerstat do

 before(:each) do
    @attr = {:jersey_number => 1, :goals => 0, :assists => 10, :shots => 1000, :fouls => 33,
      :yellow_cards => 2, :red_cards => 4, :minutes => 77, :saves => 12, :team_id => 4,
      :game_id => 3, :player_id => 2, :created_by_id => 1, :updated_by_id => 1 }
  end

  it "should create a new instance given valid attributes" do
    Playerstat.create!(@attr)
  end  
  
  describe "validate associations" do

    before(:each) do
      @team = FactoryGirl.create(:team)
      @game = FactoryGirl.create(:game)
      @player = FactoryGirl.create(:player)
      @playerstat = Playerstat.create!(@attr.merge(:team_id => @team, :game_id => @game, :player_id => @player))
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
    it "should require created_by id" do
      Playerstat.new(@attr.merge(:created_by_id => nil)).should_not be_valid
    end

    it "should require updated_by id" do
      Playerstat.new(@attr.merge(:updated_by_id => nil)).should_not be_valid
    end

    it "should require team_id id" do
      Playerstat.new(@attr.merge(:team_id => nil)).should_not be_valid
    end

    it "should require game_id id" do
      Playerstat.new(@attr.merge(:game_id => nil)).should_not be_valid
    end

    it "should require player_id id" do
      Playerstat.new(@attr.merge(:player_id => nil)).should_not be_valid
    end

    it "require jersey_number be a number" do
      Teamstat.new(@attr.merge(:jersey_number => "foo")).should_not be_valid
    end

    it "require jersey_number be >=0" do
      Teamstat.new(@attr.merge(:jersey_number => "-5")).should_not be_valid
    end
    
    it "require goals be a number" do
      Teamstat.new(@attr.merge(:goals => "foo")).should_not be_valid
    end

    it "require goals be >=0" do
      Teamstat.new(@attr.merge(:goals => "-5")).should_not be_valid
    end

    it "require assists be a number" do
      Teamstat.new(@attr.merge(:assists => "foo")).should_not be_valid
    end

    it "require assists be >=0" do
      Teamstat.new(@attr.merge(:assists => "-5")).should_not be_valid
    end

    it "require shots be a number" do
      Teamstat.new(@attr.merge(:shots => "foo")).should_not be_valid
    end

    it "require shots be >=0" do
      Teamstat.new(@attr.merge(:shots => "-5")).should_not be_valid
    end

    it "require fouls be a number" do
      Teamstat.new(@attr.merge(:fouls => "foo")).should_not be_valid
    end

    it "require fouls be >=0" do
      Teamstat.new(@attr.merge(:fouls => "-5")).should_not be_valid
    end

    it "require yellow_cards be a number" do
      Teamstat.new(@attr.merge(:yellow_cards => "foo")).should_not be_valid
    end

    it "require yellow_cards be >=0" do
      Teamstat.new(@attr.merge(:yellow_cards => "-5")).should_not be_valid
    end

    it "require red_cards be a number" do
      Teamstat.new(@attr.merge(:red_cards => "foo")).should_not be_valid
    end

    it "require red_cards be >=0" do
      Teamstat.new(@attr.merge(:red_cards => "-5")).should_not be_valid
    end

    it "require minutes be a number" do
      Teamstat.new(@attr.merge(:minutes => "foo")).should_not be_valid
    end

    it "require minutes be >=0" do
      Teamstat.new(@attr.merge(:minutes => "-5")).should_not be_valid
    end

    it "require saves be a number" do
      Teamstat.new(@attr.merge(:saves => "foo")).should_not be_valid
    end

    it "require saves be >=0" do
      Teamstat.new(@attr.merge(:saves => "foo")).should_not be_valid
    end
  end
end