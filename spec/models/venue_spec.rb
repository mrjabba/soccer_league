require 'spec_helper'

describe Venue do

  before(:each) do
    @attr = { :name => "White Hart Lane", :built => 1899, :surface => 'grass', 
    :coordinates => 'coord data 123', 
      :created_by_id => 1, :updated_by_id => 1, :teamstat_id => 1 }
  end

  it "should create a new instance given valid attributes" do
    Venue.create!(@attr)
  end

  it "should require a name" do
    Venue.new(@attr.merge(:name => "")).should_not be_valid
  end
end
