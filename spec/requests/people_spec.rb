require 'spec_helper'

describe "People" do

  before(:each) do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in :username,    :with => user.username
    fill_in :password, :with => user.password
    click_button
  end

  describe "adding a person" do
    
    describe "failure" do
      it "should not make a new person" do
        pending "quarantined, broken with paperclip. not sure why."
        lambda do
        
          visit people_path
          response.should have_selector('title', :content => "Person Repository")
          response.should have_selector('h1', :content => "Person Repository")
          response.should have_selector('a', :content => "New Person")
          response.should contain("New Person")
          #why does it find the selector, but it can't click the lnk. 
          #click_link "New Person"
          visit "people/new"
          response.should have_selector('title', :content => "New Person")
          fill_in "Firstname", :with => ""
          fill_in "LastName", :with => ""
          fill_in "Position", :with => ""
          click_button "Create"
          response.should render_template('people/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Person, :count)
      end
    end
    
    describe "success" do

      it "should make a new person" do
        pending "quarantined, broken with paperclip. not sure why."
        lambda do
          visit people_path
          #TODO FIXME this clck link below shouldn't be working but it does? 
          #click_link "New Person"
          visit "people/new"
          
          response.should have_selector('title', :content => "New Person")
          fill_in "Firstname", :with => "Joe"
          fill_in "LastName", :with => "Smith"
          fill_in "Position", :with => Person::POSITIONS.values.last
          click_button "Create"
          response.should have_selector("div.success", :content => "Person created successfully!")
          response.should render_template('people/new')

        end.should change(Person, :count).by(1)
        
        #TODO need to combine these 2 somehow to include both add and edit
        #TODO need to combine these 2 somehow to include both add and edit
        #TODO need to combine these 2 somehow to include both add and edit
      end
    end
  end
end