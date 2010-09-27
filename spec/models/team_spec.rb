require 'spec_helper'

describe Team do

  before(:each) do
    @attr = { :name => "Austin Aztex", :address1 => "123 Main St.", 
              :address2 => "Apt A", :city => "Austin", :state => "TX",
              :zip => "78704", :phone => "512-123-4567", :website => "http://foo.com", 
              :email => "test@foo.com" }
  end

  it "should create a new instance given valid attributes" do
    Team.create!(@attr)
  end

  it "should require a name" do
    no_name_team = Team.new(@attr.merge(:name => ""))
    no_name_team.should_not be_valid
  end
  
  it "should require a address1" do
    no_address1_team = Team.new(@attr.merge(:address1 => ""))
    no_address1_team.should_not be_valid
  end  
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = Team.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end  
  
  it "should reject duplicate team names" do
    Team.create!(@attr)
    team_with_duplicate_name = Team.new(@attr)
    team_with_duplicate_name.should_not be_valid
  end  
  
  it "should reject team names identical up to case" do
    upcased_name = @attr[:name].upcase
    Team.create!(@attr.merge(:name => upcased_name))
    team_with_duplicate_name = Team.new(@attr)
    team_with_duplicate_name.should_not be_valid
  end  
  
end
