require 'spec_helper'

describe "Teams" do

  before(:each) do
    user = Factory(:user)
    visit new_user_session_path
    fill_in :email,    :with => user.email
    fill_in :password, :with => user.password
    click_button
  end

  describe "adding a team" do
    
    describe "failure" do
			it "should not make a new team" do
				lambda do
					visit teams_path
          #TODO FIXME this clck link below shouldn't be working but it does? 
					#click_link "New Team"
          
					#click_link "New Player"
          visit "teams/new"
          response.should have_selector('title', :content => "New Team")
          
          response.should have_selector('title', :content => "New Team")
					fill_in "Name", :with => ""
					fill_in "Address1", :with => ""
					click_button
					response.should render_template('teams/new')
					response.should have_selector("div#error_explanation")
				end.should_not change(Team, :count)
			end
    end
    
    describe "success" do
			it "should make a new team" do
				lambda do
					visit teams_path
          #TODO FIXME this clck link below shouldn't be working but it does? 
					#click_link "New Team"
          
          visit "teams/new"
          
          response.should have_selector('title', :content => "New Team")
					fill_in "Name", :with => "FC Whatever"
					fill_in "Address1", :with => "777 Broadway"
					fill_in "Address2", :with => "Apt A"
					fill_in "City", :with => "Austin"
					fill_in "State", :with => "TX"
					fill_in "Zip", :with => "78704"
					fill_in "Phone", :with => "512-123-4567"
					fill_in "Website", :with => "http://foo.com"
					fill_in "Email", :with => "test@foo.com"
					click_button
					response.should have_selector("div.flash.success", :content => "Team created successfully!")
					response.should render_template('teams/new')
				
				end.should change(Team, :count).by(1)
        
        #TODO need to combine these 2 somehow to include both add and edit
        #TODO need to combine these 2 somehow to include both add and edit
        #TODO need to combine these 2 somehow to include both add and edit
        
      end
      
    end
    
    
  end
  

end
