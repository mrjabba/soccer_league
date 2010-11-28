require 'spec_helper'

describe "Players" do

  before(:each) do
    user = Factory(:user)
    visit signin_path
    fill_in :email,    :with => user.email
    fill_in :password, :with => user.password
    click_button
  end

  describe "adding a player" do
    
    describe "failure" do
			it "should not make a new player" do
				lambda do
        
=begin
          #testME sign them in first?
					visit signup_path
					fill_in "Name", :with => "Example User"
					fill_in "Email", :with => "user@example.com"
					fill_in "Password", :with => "foobar"
					fill_in "Confirmation", :with => "foobar"
					click_button
					response.should have_selector("div.flash.success", :content => "Welcome")
					response.should render_template('users/new')
          #testME sign them in first?
				
=end        
        
        
					visit players_path
          response.should have_selector('title', :content => "Player Repository")
          response.should have_selector('h1', :content => "Player Repository")
          response.should have_selector('a', :content => "New Player")
          response.should contain("New Player")
          #why does it find the selector, but it can't click the lnk. 
					#click_link "New Player"
          visit "players/new"
          response.should have_selector('title', :content => "New Player")
					fill_in "Firstname", :with => ""
					fill_in "LastName", :with => ""
					fill_in "Position", :with => ""
					click_button
					response.should render_template('players/new')
					response.should have_selector("div#error_explanation")
				end.should_not change(Player, :count)
			end
    end
    
    describe "success" do

			it "should make a new player" do
				lambda do
					visit players_path
          #TODO FIXME this clck link below shouldn't be working but it does? 
					#click_link "New Player"
          visit "players/new"
          
          response.should have_selector('title', :content => "New Player")
#          :firstname, :lastname, :position, :jersey_number, :birth_date, :nationality, :previous_club
					fill_in "Firstname", :with => "Joe"
					fill_in "LastName", :with => "Smith"
					fill_in "Position", :with => "Midfielder"
					click_button
					response.should have_selector("div.flash.success", :content => "Player created successfully!")
					response.should render_template('players/new')
				
				end.should change(Player, :count).by(1)
        
        #TODO need to combine these 2 somehow to include both add and edit
        #TODO need to combine these 2 somehow to include both add and edit
        #TODO need to combine these 2 somehow to include both add and edit
        
      end
      
    end
    
    
  end
  

end
