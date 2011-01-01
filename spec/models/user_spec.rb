require 'spec_helper'

describe User do
	
	before(:each) do
		@attr = { 
		:username => "myusername", 
		:email => "user@example.com",
		:password => "foobar",
		:password_confirmation => "foobar"
		}
	end

  it "should have an user (update_by) field"

  it "should allow users to have many leagues, players, and so on"
	
	it "should create a new instance given valid attributes" do
		User.create!(@attr)
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
	

end
