require 'spec_helper'

describe "Teams" do
  test_file = File.new("public/images/calendar.png")

  before(:each) do
    user = FactoryGirl.create(:user)
    visit "/#{I18n.locale}/users/sign_in"
    fill_in "user_username",    :with => user.username
    fill_in "user_password", :with => user.password
    click_button
  end

  describe "adding a team" do
    
    describe "failure" do
      it "should not make a new team" do
        lambda do
          visit new_team_path
          response.should have_selector('title', :content => "New Team")
          fill_in "team_name", :with => ""
          fill_in "team_address1", :with => ""
          fill_in "Avatar", :with => test_file
          click_button
          response.should render_template('teams/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Team, :count)
      end
    end
    
    describe "success" do
      it "should make a new team" do
        lambda do
          visit new_team_path
          response.should have_selector('title', :content => "New Team")
          fill_in "team_name", :with => "FC Whatever"
          fill_in "team_address1", :with => "777 Broadway"
          fill_in "team_address2", :with => "Apt A"
          fill_in "team_city", :with => "Austin"
          fill_in "team_state", :with => "TX"
          fill_in "team_zip", :with => "78704"
          fill_in "team_phone", :with => "512-123-4567"
          fill_in "team_website", :with => "http://foo.com"
          fill_in "team_email", :with => "test@foo.com"
          fill_in "Avatar", :with => test_file
          click_button
          response.should have_selector("div.success", :content => "Team created successfully!")
          response.should render_template('teams/new')
        end.should change(Team, :count).by(1)
      end
    end
  end
end