require 'spec_helper'

describe Organization do
  before(:each) do
    @attr = { :name => "United States Soccer Federation", :founded => 1913, :created_by_id => 1, :updated_by_id => 1 }
  end

  it "should create a new instance given valid attributes" do
    @rganization = Organization.create!(@attr)
  end

  it "should require a name" do
    Organization.new(@attr.merge(:name => "")).should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 256
    Organization.new(@attr.merge(:name => long_name)).should_not be_valid
  end

  it "should require a founded where soccer was played" do
    Organization.new(@attr.merge(:founded => 1250)).should_not be_valid
  end

  it "should require founded be a positive number" do
    Organization.new(@attr.merge(:founded => -3)).should_not be_valid
  end

  it "should require founded be a number" do
    Organization.new(@attr.merge(:founded => "foo")).should_not be_valid
  end

  it "should require created by id" do
      Organization.new(@attr.merge(:created_by_id => nil)).should_not be_valid
  end

  it "should require updated by id" do
      Organization.new(@attr.merge(:updated_by_id => nil)).should_not be_valid
  end
end
