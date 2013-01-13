require 'spec_helper'

describe Playinglocation do
  before(:each) do
    @attr = { :venue_id => 999, :teamstat_id => 888, :created_by_id => 1, :updated_by_id => 1 }
  end

  it "should create a new instance given valid attributes" do
    Playinglocation.create!(@attr)
  end

  it "should require a venue" do
    Playinglocation.new(@attr.merge(:venue_id => nil)).should_not be_valid
  end

  it "should require a teamstat" do
    Playinglocation.new(@attr.merge(:teamstat_id => nil)).should_not be_valid
  end
end
