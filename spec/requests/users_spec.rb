require 'spec_helper'

describe "Users" do
describe "signup" do
  describe "failure" do
    it "should not make a new user" do
      lambda do
          visit "/#{I18n.locale}/users/sign_up"
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
          visit "/#{I18n.locale}/users/sign_up"
          fill_in "Username", :with => "myuser"
          fill_in "Email", :with => "user@example.com"
          fill_in "Password", :with => "foobar"
          fill_in "Password confirmation", :with => "foobar"
          click_button
          response.should have_selector("div.alert", :content => "You have signed up successfully")
          response.should render_template('devise/registrations/new')
        end.should change(User, :count).by(1)
      end
    end
  end
  
  describe "sign in/out" do
    describe "failure" do
      it "should not sign a user in" do
        visit "/#{I18n.locale}/users/sign_in"
        fill_in "user_username",   :with => ""
        fill_in "user_password",  :with => ""
        click_button
        response.should have_selector("div.alert", :content => "Invalid")
      end
    end
    
    describe "success" do
      it "should sign a user in and out" do
        user = FactoryGirl.create(:user)
        visit "/#{I18n.locale}/users/sign_in"
        fill_in "user_username",   :with => user.username
        fill_in "user_password", :with => user.password
        click_button
        response.should have_selector("li a", :content => "Sign out")
        click_link "Sign out"
        response.should have_selector("li a", :content => "Sign In")
      end
    end
  end
end