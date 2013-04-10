require 'spec_helper'

describe Technicalstaff do

  before(:each) do
    @teamstat = FactoryGirl.create(:teamstat)
    @person = FactoryGirl.create(:person)
    @attr = { :teamstat_id => @teamstat.id, :person_id => @person.id, :created_by_id => 1, :updated_by_id => 1 }
  end

  it "should create a new instance given valid attributes" do
    Technicalstaff.create!(@attr)
  end

#  it { should validate_presence_of(:teamstat_id) }

  it "should require a teamstat" do
    Technicalstaff.new(@attr.merge(:teamstat_id => "")).should_not be_valid
  end

  it "should require a person" do
    Technicalstaff.new(@attr.merge(:person_id => "")).should_not be_valid
  end

  it "should require created by id" do
    Technicalstaff.new(@attr.merge(:created_by_id => nil)).should_not be_valid
  end

  it "should require updated by id" do
    Technicalstaff.new(@attr.merge(:updated_by_id => nil)).should_not be_valid
  end
end
