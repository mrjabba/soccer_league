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

  it { should ensure_length_of(:firstname).is_at_most(50) }
  it { should ensure_length_of(:lastname).is_at_most(50) }
  it { should validate_presence_of(:created_by_id) }
  it { should validate_presence_of(:updated_by_id) }

 it "should reject no name" do
    Person.new(@attr.merge(:firstname => "", :lastname => "")).should_not be_valid
  end
 
 it "should reject positions not in the position list" do
    Person.new(@attr.merge(:position => "coach")).should_not be_valid
  end
  
  it "should return an array of id/name pairs" do
    person = Person.create!(@attr)
    Person.fetch_people_by_first_name_as_array(@attr[:firstname].downcase).should eql([{:id => person.id, :name => person.name}])
  end

  describe 'name' do
    it "should display a full name" do
      Person.new(@attr).name.should eql("#{@attr[:firstname]} #{@attr[:lastname]}")
    end

    describe 'when no first name' do
      it "should display last name" do
        Person.new(@attr.merge(:firstname => "")).name.should eql(@attr[:lastname])
      end
    end

    describe 'when no last name' do
      it "should display first name" do
        Person.new(@attr.merge(:lastname => "")).name.should eql(@attr[:firstname])
      end
    end
  end
  
  describe 'custom finders' do
    let(:search) { 'van'}
    describe 'people do not exist' do
      describe 'search' do
        it 'return an empty result' do
          Person.search(search).count.should == 0
        end
      end
    end

    describe 'people exist' do
      before do
        @person = FactoryGirl.create(:person)
        person_other = FactoryGirl.create(:person)
      end

      describe 'search' do
        it 'returns people based on name search' do
          result = Person.search(search)
          result.count.should == 2
          result.first.should == @person
        end
      end
    end
  end
end
