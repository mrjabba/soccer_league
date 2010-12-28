require 'spec_helper'

describe "Users" do

	describe "signup" do
		
		describe "failure" do
			it "should not make a new user" do
				lambda do
					visit new_user_registration_path
#					fill_in "Name", :with => ""
					fill_in "Email", :with => ""
					fill_in "Password", :with => ""
					fill_in "Password confirmation", :with => ""
          
					click_button
					response.should render_template('devise/registrations/new')
					response.should have_selector("div#error_explanation")
				end.should_not change(User, :count)
			end
		end
		
		describe "success" do
		
			it "should make a new user" do
				lambda do
					visit new_user_registration_path
					fill_in "Username", :with => "myuser"
					fill_in "Email", :with => "user@example.com"
					fill_in "Password", :with => "foobar"
					fill_in "Password confirmation", :with => "foobar"
					click_button
					response.should have_selector("div.flash.notice", :content => "You have signed up successfully")
					response.should render_template('devise/registrations/new')
				
				end.should change(User, :count).by(1)
			end
		
		end
		
	end
  
  describe "sign in/out" do
    describe "failure" do
      it "should not sign a user in" do
        visit new_user_session_path
        fill_in :username,   :with => ""
        fill_in :password,  :with => ""
        click_button
        response.should have_selector("div.flash.alert", :content => "Invalid")
      end
    end
    
    describe "success" do

      it "should sign a user in and out" do
        user = Factory(:user)
        visit new_user_session_path
        fill_in :username,   :with => user.username
        fill_in :password, :with => user.password
        click_button
        response.should have_selector("li a", :content => "Sign out")
        click_link "Sign out"
        response.should have_selector("li a", :content => "Sign in")
      end
    
    end
    
  end


end
