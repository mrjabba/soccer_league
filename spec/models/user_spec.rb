require 'spec_helper'

describe User do
    
  before(:each) do
    @attr = { 
    :username => "myusername", 
    :email => "user@example.com",
    :password => "foobar",
    :password_confirmation => "foobar",
    }
  end

  it "should persist default preference for metric units" do
    user = User.create!(@attr)
    user.metric.should be_true
  end

  it "should persist preference for english units" do
    user = User.create!(@attr.merge(:metric => false))
    user.metric.should be_false
  end

  it "should have an user (update_by) field"

  it "should have save a user as an admin role"

  it "should allow users to have many leagues, people, and so on"
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should persist single roles" do
    user = User.create!(@attr.merge(:perms => ["admin"]))
    user.has_any_role?(:admin).should be_true
  end

  it "should persist multiple roles" do
    user = User.create!(@attr.merge(:perms => ["admin", "free"]))
    user.has_any_role?(:admin).should be_true
    user.has_any_role?(:free).should be_true
    user.has_any_role?(:noexist).should be_false
  end


  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should require a username" do
    no_username_user = User.new(@attr.merge(:username => ""))
    no_username_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:username => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  describe 'custom finders' do
    let(:search) { 'user'}
    describe 'users do not exist' do
      describe 'search' do
        it 'return an empty result' do
          User.search(search).count.should == 0
        end
      end
    end

    describe 'users exist' do
      before do
        @user = FactoryGirl.create(:user)
        user_other = FactoryGirl.create(:user)
      end

      describe 'search' do
        it 'returns users based on name search' do
          result = User.search(search)
          result.count.should == 2
          result.first.should == @user
        end
      end
    end
  end


end
