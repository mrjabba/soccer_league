require 'spec_helper'

describe League do

  before(:each) do
    @attr = { :name => "MLS", :to_year => 2002, :from_year => 2001, :created_by_id => 1, :updated_by_id => 1, :organization_id => 1, :supports_games => true, :calc_points => true }
  end

  it "should create a new instance given valid attributes" do
    @league = League.create!(@attr)
  end

  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should validate_presence_of(:to_year) }
  it { should validate_presence_of(:from_year) }
  it { should validate_presence_of(:created_by_id) }
  it { should validate_presence_of(:updated_by_id) }
  it { should validate_numericality_of(:to_year) }
  it { should validate_numericality_of(:from_year) }
  it { should ensure_inclusion_of(:to_year).in_range(1800..2500) }
  it { should ensure_inclusion_of(:from_year).in_range(1800..2500) }

  it "should know if games exist for the league" do
    league = FactoryGirl.create(:game).league
    league.games_exist?.should be_true
  end
end
