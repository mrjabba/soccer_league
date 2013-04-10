require 'spec_helper'

describe Playinglocation do
  before(:each) do
    @attr = { :venue_id => 999, :teamstat_id => 888, :created_by_id => 1, :updated_by_id => 1 }
  end

  it "should create a new instance given valid attributes" do
    Playinglocation.create!(@attr)
  end

  it { should validate_presence_of(:venue_id) }
  it { should validate_presence_of(:teamstat_id) }
end
