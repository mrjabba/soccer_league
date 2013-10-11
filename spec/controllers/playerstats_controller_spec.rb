require 'spec_helper'

describe PlayerstatsController do
 render_views

  describe "GET 'new'" do
    let(:game) { FactoryGirl.create(:game) }
    let(:teamstat) { FactoryGirl.create(:teamstat) }
    before(:each) do
      sign_in(FactoryGirl.create(:user))
    end
      
    it "should be successful with a game and a teamstat" do
      get :new, :game_id => game, :teamstat_id => teamstat
      response.should be_success
    end

    it "should have the right title" do
      get :new, :game_id => game, :teamstat_id => teamstat
      response.should have_selector("title", :content => "New Playerstat")
    end
  end

  describe "DELETE 'destroy'" do
    let!(:playerstat) do
      sign_in(FactoryGirl.create(:user, :email => FactoryGirl.generate(:email)))
      FactoryGirl.create(:playerstat)
    end

    describe "success" do
      it "should destroy the playerstat" do
        lambda do 
          delete :destroy, :id => playerstat
        end.should change(Playerstat, :count).by(-1)
      end

      it "should redirect to the game show page" do
        delete :destroy, :id => playerstat
        response.should redirect_to(game_path(playerstat.game))
      end
    end
  end

  describe "POST 'create'" do
    let(:game) { FactoryGirl.create(:game) }
    let(:teamstat) { FactoryGirl.create(:teamstat) }
    let(:person) { FactoryGirl.create(:person) }

    before(:each) do
      sign_in(FactoryGirl.create(:user, :email => FactoryGirl.generate(:email)))
    end

    describe "success" do
      let(:attr) { { :game_id => game, :teamstat_id => teamstat, :person_id => person } }

      it "should redirect to the game show page" do
        post :create, :playerstat => attr
        response.should redirect_to(game_path(game))
      end
      
      it "should have a flash message" do
        post :create, :playerstat => attr
        flash[:success].should =~ /Person added to game successfully/
      end
    end

    describe "failure" do
      let(:attr) { { :game_id => game, :teamstat_id => teamstat } }

      it "should render the 'new' page" do
        post :create, :playerstat => attr
        response.should render_template('new')        
      end
      
      it "should have the right title" do
        post :create, :playerstat => attr
        response.should have_selector("title", :content => "New Playerstat")
      end
    end
  end
end