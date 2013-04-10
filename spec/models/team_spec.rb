require 'spec_helper'

describe Team do
  before(:each) do
    @attr = { :name => "Austin Aztex", :address1 => "123 Main St.",
              :address2 => "Apt A", :city => "Austin", :state => "TX",
              :zip => "78704", :phone => "", :website => "http://foo.com",
              :email => "test@foo.com", :country => "USA", :created_by_id => 1, :updated_by_id => 1 }
  end


  it "should create a new instance given valid attributes" do
    Team.create!(@attr)
  end

 it "should reject phone format if incorrect" do
    Team.new(@attr.merge(:phone => "abc-notvalid")).should_not be_valid
  end

  it "should reject email format if incorrect" do
    Team.new(@attr.merge(:email => "memecom")).should_not be_valid
  end

  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should validate_presence_of(:address1) }
  it { should validate_presence_of(:created_by_id) }
  it { should validate_presence_of(:updated_by_id) }

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
