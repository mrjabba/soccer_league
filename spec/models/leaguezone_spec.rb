require 'spec_helper'

describe Leaguezone do
  let(:league) { FactoryGirl.create(:league) }

  before(:each) do
    @attr = { :name => "promotion", :description => "foo", :start_rank => 1, :end_rank => 3,
              :style => "foo", :created_by_id => 1, :updated_by_id => 1, :league_id => league.id }
  end

  it "should create a new instance given valid attributes" do
    Leaguezone.create!(@attr)
  end

  it "should require a league" do
    Leaguezone.new(@attr.merge(:league_id => nil)).should_not be_valid
  end

  it "should require a name" do
    Leaguezone.new(@attr.merge(:name => "")).should_not be_valid
  end

  it "should require a style" do
    Leaguezone.new(@attr.merge(:style => "")).should_not be_valid
  end

  it "should require start_rank" do
    Leaguezone.new(@attr.merge(:start_rank => nil)).should_not be_valid
  end

  it "should require end_rank" do
    Leaguezone.new(@attr.merge(:end_rank => nil)).should_not be_valid
  end

  it "should require ranks be a positive number" do
    Leaguezone.new(@attr.merge(:start_rank => -3)).should_not be_valid
    Leaguezone.new(@attr.merge(:end_rank => -3)).should_not be_valid
  end
end
