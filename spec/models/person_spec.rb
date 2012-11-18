require 'spec_helper'

describe Person do
  before(:each) do
    @attr = { :firstname => "John", :lastname => "Doe", :position => Person::POSITIONS.values.last,
    :birth_date => "02/10/1978", :nationality => "USA",
    :birth_city => "Austin", :birth_nation => "USA", :height => 20, :created_by_id => 1, :updated_by_id => 1}
  end

  it "should populate height_feet/height_inches on load"
  
  it "should allow entering height as meters(decimal)" do
    person = Person.new(@attr)
    person.height_meters = 1.73
    person.height.should == 1.73
  end

  it "should require feet when inches are specified" do
    person = Person.new(@attr)
    person.height_inches = 8
    person.height_feet = ""
    person.should_not be_valid
  end

  it "should require inches when feet are specified" do
    person = Person.new(@attr)
    person.height_feet = 5
    person.height_inches = ""
    person.should_not be_valid
  end

  it "should create a new instance given valid attributes" do
    Person.create!(@attr)
  end

  it "should require a first name" do
    Person.new(@attr.merge(:firstname => "")).should_not be_valid
  end

  it "should require a last name" do
    Person.new(@attr.merge(:lastname => "")).should_not be_valid
  end

  it "should reject positions not in the position list" do
    Person.new(@attr.merge(:position => "coach")).should_not be_valid
  end
  
  it "should reject firstnames that are too long" do
    long_name = "a" * 51
    Person.new(@attr.merge(:firstname => long_name)).should_not be_valid
  end

  it "should reject lastnames that are too long" do
    long_name = "a" * 51
    Person.new(@attr.merge(:lastname => long_name)).should_not be_valid
  end

  it "should require created by id" do
    Person.new(@attr.merge(:created_by_id => nil)).should_not be_valid
  end

  it "should require updated by id" do
    Person.new(@attr.merge(:updated_by_id => nil)).should_not be_valid
  end

  it "should display a full name" do
    Person.new(@attr).name.should eql("#{@attr[:firstname]} #{@attr[:lastname]}")
  end

  it "should return an array of id/name pairs" do
    person = Person.create!(@attr)
    Person.fetch_people_by_first_name_as_array(@attr[:firstname].downcase).should eql([{:id => person.id, :name => person.name}])
  end
end
