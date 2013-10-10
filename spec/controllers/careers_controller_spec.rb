require 'spec_helper'

describe CareersController do
  render_views

  describe "GET 'show'" do
    let(:roster) do
      FactoryGirl.create(:roster)
    end
    describe 'career hack' do
      it "should be successful" do
        get :show, :id => roster.person_id
        response.should be_success
      end

      it "should find the right roster" do
        get :show, :id => roster.person_id
        response.should render_template('career')
      end
  
      it "should have the header" do
        get :show, :id => roster.person_id
        response.should have_selector("h3", :content => "Career")
      end
    end
  end

end

