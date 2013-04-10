require 'spec_helper'

describe Leaguezone do
  let(:league) { FactoryGirl.create(:league) }

  before(:each) do
    @attr = { :name => "promotion", :description => "foo", :start_rank => 1, :end_rank => 3,
              :style => "foo", :created_by_id => 1, :updated_by_id => 1, :league_id => league.id }
  end

  it "should create a new instance given valid attributes" do
    Leaguezone.create!(@attr)
  end

  it { should validate_presence_of(:league_id) }
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(50) }
  it { should validate_presence_of(:style) }
  it { should ensure_length_of(:style).is_at_most(50) }
  it { should validate_presence_of(:start_rank) }
  it { should validate_presence_of(:end_rank) }

  it { should validate_numericality_of(:start_rank) }
  it { should validate_numericality_of(:end_rank) }
end
