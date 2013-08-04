require 'spec_helper'

describe Venue do

  before(:each) do
    @attr = { :name => "White Hart Lane",  :description => "description",
      :directions => "from here to there", :address => "123 main",
      :built => 1899, :surface => 'grass', 
    :coordinate_lat => '51.603333',  :coordinate_long => '-0.065833',
      :created_by_id => 1, :updated_by_id => 1 }
  end

  it "should create a new instance given valid attributes" do
    Venue.create!(@attr)
  end

  it "should require a name" do
    Venue.new(@attr.merge(:name => "")).should_not be_valid
  end
end
