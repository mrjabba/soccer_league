require 'spec_helper'

describe Player do
  before(:each) do
    @attr = { :firstname => "Jamie", :lastname => "Watson", :position => Player::POSITIONS.values.first,
    :jersey_number => 10, :birth_date => "02/10/1978", :nationality => "USA",
    :birth_city => "Austin", :birth_nation => "USA", :height => 20, :created_by_id => 1}
  end

  it "should calculate/persist height as millimeters, allow input as meters (decimal)"

  it "should have an user (update_by) field"

  it "should create a new instance given valid attributes" do
    Player.create!(@attr)
  end

  it "should require a first name" do
    Player.new(@attr.merge(:firstname => "")).should_not be_valid
  end

  it "should require a last name" do
    Player.new(@attr.merge(:lastname => "")).should_not be_valid
  end
  
  it "should require a position" do
    Player.new(@attr.merge(:position => "")).should_not be_valid
  end

  it "should reject positions not in the position list" do
    player = Player.new(@attr.merge(:position => "coach")).should_not be_valid
  end
  
  it "should reject firstnames that are too long" do
    long_name = "a" * 51
    Player.new(@attr.merge(:firstname => long_name)).should_not be_valid
  end

  it "should reject lastnames that are too long" do
    long_name = "a" * 51
    Player.new(@attr.merge(:lastname => long_name)).should_not be_valid
  end

  it "should require created by id" do
    Player.new(@attr.merge(:created_by_id => nil)).should_not be_valid
  end
end