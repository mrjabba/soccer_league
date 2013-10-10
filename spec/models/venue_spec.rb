require 'spec_helper'

describe Venue do

  before(:each) do
    @attr = { :name => "White Hart Lane",  :description => "description",
      :directions => "from here to there", :address => "123 main",
      :built => 1899, :surface => 'grass', 
    :coordinate_lat => '51.603333',  :coordinate_long => '-0.065833',
      :created_by_id => 1, :updated_by_id => 1 }
  end

  it "should create a new instance given valid attributes" do
    Venue.create!(@attr)
  end

  it "should require a name" do
    Venue.new(@attr.merge(:name => "")).should_not be_valid
  end

  describe 'custom finders' do
    let(:search) { 'stadium'}
    describe 'venues do not exist' do
      describe 'search' do
        it 'return an empty result' do
          Venue.search(search).count.should == 0
        end
      end

      describe 'fetch_venues_by_name_as_array' do
        it 'returns an empty array with no match' do
          Venue.fetch_venues_by_name_as_array('zzz').should == []
        end
      end

      describe 'fetch_venues_for_league' do
        it 'return an empty result' do
          Venue.fetch_venues_for_league(123).count.should == 0
        end
      end
    end

    describe 'venues exist' do
      before do
        @venue = FactoryGirl.create(:venue)
        venue_other = FactoryGirl.create(:venue)
      end

      describe 'search' do
        it 'returns venues based on name search' do
          result = Venue.search(search)
          result.count.should == 2
          result.first.should == @venue
        end
      end

      describe 'fetch_venues_by_name_as_array' do
        it 'returns expected hash with match' do
          result = Venue.fetch_venues_by_name_as_array(search)
          result.size.should == 2
          result.first[:name].should == @venue.name
          result.first[:id].should == @venue.id
        end
      end

      describe 'fetch_venues_for_league' do
        let(:playinglocation) { FactoryGirl.create(:playinglocation) }
        it 'return an empty result' do
          league_id = playinglocation.teamstat.league.id
          Venue.fetch_venues_for_league(league_id).count.should == 1
        end
      end
    end
  end
end
