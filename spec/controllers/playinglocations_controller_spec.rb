require 'spec_helper'

describe PlayinglocationsController do
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
      response.should have_selector("title", :content => "New Playing Location")
    end
  end

  describe "POST 'create'" do
    describe 'success' do
      let(:venue) { FactoryGirl.create(:venue)}
      let(:teamstat) { FactoryGirl.create(:teamstat)}
      let(:attr) { {:venue_id => venue.id, :teamstat_id => teamstat.id} }
      before(:each) do
        sign_in(FactoryGirl.create(:user))
      end

      it "should create a playinglocation" do
        lambda do
          post :create, :teamstat_id => teamstat, :playinglocation => attr
        end.should change(Playinglocation, :count).by(1)
      end

      it "should redirect to the teamstat show page" do
          post :create, :teamstat_id => teamstat, :playinglocation => attr
        response.should redirect_to(teamstat_path(assigns(:teamstat)))
      end

      it "should have a flash message" do
          post :create, :teamstat_id => teamstat, :playinglocation => attr
        flash[:success].should =~ /Playing location created successfully!/
      end
    
    end

    describe "failure" do
     let(:attr) { {} }
     before(:each) do
       sign_in(FactoryGirl.create(:user))
     end

      describe 'when no teamstat' do
        let(:venue) { FactoryGirl.create(:venue) }
        it "should render a 404" do
          lambda do
            post :create, :teamstat_id => attr, :venue => venue
          end.should raise_error(ActionController::RoutingError)
        end
      end

      describe 'with teamstat and no venue' do
        let(:teamstat) { FactoryGirl.create(:teamstat) }
        it "should not create a playinglocation" do
          lambda do
            post :create, :teamstat_id => teamstat, :venue => attr
          end.should_not change(Playinglocation, :count)
        end
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @playinglocation = FactoryGirl.create(:playinglocation)
      sign_in(FactoryGirl.create(:user))
    end

    describe "success" do
      it "should destroy the playinglocation" do
        lambda do
          delete :destroy, :id => @playinglocation
        end.should change(Playinglocation, :count).by(-1)
      end

      it "should redirect to the teamstat show page" do
        teamstat_id = @playinglocation.teamstat_id
        delete :destroy, :id => @playinglocation
        response.should redirect_to(teamstat_path(teamstat_id))
      end
    end
  end

end