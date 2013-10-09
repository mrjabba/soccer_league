require 'spec_helper'

describe TechnicalstaffsController do
 render_views

  describe "GET 'new'" do
    let(:teamstat) do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:teamstat)
    end

    it "should be successful" do
      get 'new', :teamstat_id => teamstat
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new', :teamstat_id => teamstat
      response.should have_selector("title", :content => "New Technical Staff")
    end
  end

  describe "POST 'create'" do
    describe "failure" do
     let(:attr) { {} }
     before(:each) do
       sign_in(FactoryGirl.create(:user))
     end

      describe 'when no teamstat' do
        let(:person) { FactoryGirl.create(:person) }
        it "should render a 404" do
          lambda do
            post :create, :teamstat_id => attr, :person => person
          end.should raise_error(ActionController::RoutingError)
        end
      end

      describe 'with teamstat and no person' do
        let(:teamstat) { FactoryGirl.create(:teamstat) }
        it "should not create a technicalstaff" do
          lambda do
            post :create, :teamstat_id => teamstat, :person => attr
          end.should_not change(Technicalstaff, :count)
        end
      end
    end
  end
end