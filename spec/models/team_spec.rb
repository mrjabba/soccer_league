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

  describe 'custom finders' do
    let(:search) { 'some'}
    describe 'teams do not exist' do
      describe 'search' do
        it 'return an empty result' do
          Team.search(search).count.should == 0
        end
      end

      describe 'fetch_teams_by_name_as_array' do
        it 'returns an empty array with no match' do
          Team.fetch_teams_by_name_as_array('zzz').should == []
        end
      end
    end

    describe 'teams exist' do
      before do
        @team = FactoryGirl.create(:team)
        team_other = FactoryGirl.create(:team)
      end

      describe 'search' do
        it 'returns teams based on name search' do
          result = Team.search(search)
          result.count.should == 2
          result.first.should == @team
        end
      end

      describe 'fetch_teams_by_name_as_array' do
        it 'returns expected hash with match' do
          result = Team.fetch_teams_by_name_as_array(search)
          result.size.should == 2
          result.first[:name].should == @team.name
          result.first[:id].should == @team.id
        end
      end
    end
  end

end
