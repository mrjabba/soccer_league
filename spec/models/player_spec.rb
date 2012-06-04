require 'spec_helper'

describe Player do
  before(:each) do
    @attr = { :firstname => "John", :lastname => "Doe", :position => Player::POSITIONS.values.first,
    :jersey_number => 10, :birth_date => "02/10/1978", :nationality => "USA",
    :birth_city => "Austin", :birth_nation => "USA", :height => 20, :created_by_id => 1, :updated_by_id => 1}
  end

  it "should populate height_feet/height_inches on load"
  
  it "should allow entering height as meters(decimal)" do
    player = Player.new(@attr)
    player.height_meters = 1.73
    player.height.should == 1.73
  end

  it "should require feet when inches are specified" do
    player = Player.new(@attr)
    player.height_inches = 8
    player.height_feet = ""
    player.should_not be_valid
  end

  it "should require inches when feet are specified" do
    player = Player.new(@attr)
    player.height_feet = 5
    player.height_inches = ""
    player.should_not be_valid
  end

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

  it "should require updated by id" do
    Player.new(@attr.merge(:updated_by_id => nil)).should_not be_valid
  end

  it "should display a full name" do
    Player.new(@attr).name.should eql("#{@attr[:firstname]} #{@attr[:lastname]}")
  end

  it "should return an array of id/name pairs" do
    player = Player.create!(@attr)
    Player.fetch_players_by_first_name_as_array(@attr[:firstname]).should eql([{:id => player.id, :name => player.name}])
  end
end
