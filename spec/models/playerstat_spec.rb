require 'spec_helper'

describe Playerstat do

 before(:each) do
    @attr = {:jersey_number => 1, :goals => 0, :assists => 10, :shots => 1000, :fouls => 33,
      :yellow_cards => 2, :red_cards => 4, :minutes => 77, :saves => 12, :teamstat_id => 4,
      :game_id => 3, :person_id => 2, :created_by_id => 1, :updated_by_id => 1 }
  end

  it "should create a new instance given valid attributes" do
    Playerstat.create!(@attr)
  end  
  
  describe "validate associations" do

    before(:each) do
      @teamstat = FactoryGirl.create(:teamstat)
      @game = FactoryGirl.create(:game)
      @person = FactoryGirl.create(:person)
      @playerstat = Playerstat.create!(@attr.merge(:teamstat_id => @teamstat.id, :game_id => @game.id, :person_id => @person.id))
    end

    it "should have the right associated person" do
      @playerstat.person_id.should == @person.id
      @playerstat.person.should == @person
    end

    it "should have the right associated game" do
      @playerstat.game_id.should == @game.id
      @playerstat.game.should == @game
    end

    it "should have the right associated teamstat" do
      @playerstat.teamstat_id.should == @teamstat.id
      @playerstat.teamstat.should == @teamstat
    end
  end
  
  describe "validations" do
    it "should require created_by id" do
      Playerstat.new(@attr.merge(:created_by_id => nil)).should_not be_valid
    end

    it "should require updated_by id" do
      Playerstat.new(@attr.merge(:updated_by_id => nil)).should_not be_valid
    end

    it "should require teamstat_id id" do
      Playerstat.new(@attr.merge(:teamstat_id => nil)).should_not be_valid
    end

    it "should require game_id id" do
      Playerstat.new(@attr.merge(:game_id => nil)).should_not be_valid
    end

    it "should require person_id id" do
      Playerstat.new(@attr.merge(:person_id => nil)).should_not be_valid
    end

    it "require jersey_number be a number" do
      Playerstat.new(@attr.merge(:jersey_number => "foo")).should_not be_valid
    end

    it "require jersey_number be >=0" do
      Playerstat.new(@attr.merge(:jersey_number => "-5")).should_not be_valid
    end
    
    it "require goals be a number" do
      Playerstat.new(@attr.merge(:goals => "foo")).should_not be_valid
    end

    it "require goals be >=0" do
      Playerstat.new(@attr.merge(:goals => "-5")).should_not be_valid
    end

    it "require assists be a number" do
      Playerstat.new(@attr.merge(:assists => "foo")).should_not be_valid
    end

    it "require assists be >=0" do
      Playerstat.new(@attr.merge(:assists => "-5")).should_not be_valid
    end

    it "require shots be a number" do
      Playerstat.new(@attr.merge(:shots => "foo")).should_not be_valid
    end

    it "require shots be >=0" do
      Playerstat.new(@attr.merge(:shots => "-5")).should_not be_valid
    end

    it "require fouls be a number" do
      Playerstat.new(@attr.merge(:fouls => "foo")).should_not be_valid
    end

    it "require fouls be >=0" do
      Playerstat.new(@attr.merge(:fouls => "-5")).should_not be_valid
    end

    it "require yellow_cards be a number" do
      Playerstat.new(@attr.merge(:yellow_cards => "foo")).should_not be_valid
    end

    it "require yellow_cards be >=0" do
      Playerstat.new(@attr.merge(:yellow_cards => "-5")).should_not be_valid
    end

    it "require red_cards be a number" do
      Playerstat.new(@attr.merge(:red_cards => "foo")).should_not be_valid
    end

    it "require red_cards be >=0" do
      Playerstat.new(@attr.merge(:red_cards => "-5")).should_not be_valid
    end

    it "require minutes be a number" do
      Playerstat.new(@attr.merge(:minutes => "foo")).should_not be_valid
    end

    it "require minutes be >=0" do
      Playerstat.new(@attr.merge(:minutes => "-5")).should_not be_valid
    end

    it "require saves be a number" do
      Playerstat.new(@attr.merge(:saves => "foo")).should_not be_valid
    end

    it "require saves be >=0" do
      Playerstat.new(@attr.merge(:saves => "foo")).should_not be_valid
    end
  end
end