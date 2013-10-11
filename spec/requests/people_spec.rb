require 'spec_helper'

describe "People" do
  test_file = File.new("public/images/calendar.png")

  before(:each) do
    user = FactoryGirl.create(:user)
    visit "/#{I18n.locale}/users/sign_in"
    fill_in "user_username", :with => user.username
    fill_in "user_password", :with => user.password
    click_button
  end

  describe "adding a person" do
    
    describe "failure" do
      it "should not make a new person" do
        lambda do
          visit new_person_path
          response.should have_selector('title', :content => "New Person")
          response.should have_selector('h1', :content => "New Person")
          response.should contain("Cancel")
          fill_in "Firstname", :with => ""
          fill_in "LastName", :with => ""
          fill_in "Position", :with => ""
          fill_in "Avatar", :with => test_file
          click_button "Create"
          response.should render_template('people/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Person, :count)
      end
    end
    
    describe "success" do

      it "should make a new person" do
        lambda do
          visit new_person_path
          response.should have_selector('title', :content => "New Person")
          fill_in "Firstname", :with => "Joe"
          fill_in "LastName", :with => "Smith"
          fill_in "Position", :with => Person::POSITIONS.values.last
          fill_in "Avatar", :with => test_file
          click_button "Create"
          response.should have_selector("div.success", :content => "Person created successfully!")
          response.should render_template('people/new')
        end.should change(Person, :count).by(1)
      end
    end
  end
end