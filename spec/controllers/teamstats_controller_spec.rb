require 'spec_helper'

describe TeamstatsController do
 render_views

  describe "PUT 'update'" do
    let(:teamstat) do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:teamstat)
    end

    describe "success" do
      let(:attr) {  }

      it "should redirect to the teamstat show page" do
        put :update, :id => teamstat, :teamstat => attr
        response.should redirect_to(teamstat_path(teamstat))
      end

      it "should have a flash message" do
        put :update, :id => teamstat, :teamstat => attr
        flash[:success].should =~ /updated/
      end
    end
  end

  describe "GET 'new'" do
    let(:league) do
      sign_in(FactoryGirl.create(:user))
      FactoryGirl.create(:league)
    end
      
    it "should be successful with a league" do
      get :new, :league_id => league
      response.should be_success
    end

    it "should have the right title" do
      get :new, :league_id => league
      response.should have_selector("title", :content => "New Teamstat")
    end
  end

  it "should allow the league_table_editor role to override league table settings, ex: docking points"

  describe "GET 'show'" do
    let(:roster) { FactoryGirl.create(:roster) }

    it "should be successful with a teamstat(roster)" do
      get :show, :id => roster.teamstat
      response.should be_success
    end

    it "should have the right title" do
      get :show, :id => roster.teamstat
      response.should have_selector("title",
          :content => "View Roster | #{roster.teamstat.league.name} | #{roster.teamstat.league.from_year}-#{roster.teamstat.league.to_year} | #{roster.teamstat.team.name}")
    end
  end

 describe "GET 'edit'" do
   let(:teamstat) do
     sign_in FactoryGirl.create(:user)
     FactoryGirl.create(:teamstat)
   end

   it "should be successful" do
     get :edit, :id => teamstat
     response.should be_success
   end

   it "should have the right title" do
     get :edit, :id => teamstat
     response.should have_selector("title", :content => "Edit Teamstat")
   end
 end

 describe "DELETE 'destroy'" do
    #why did let not work here?
    before(:each) do
      @teamstat = FactoryGirl.create(:teamstat)
      sign_in(FactoryGirl.create(:user))
    end

    describe "success" do
      it "should destroy the teamstat" do
        lambda do 
          delete :destroy, :id => @teamstat
        end.should change(Teamstat, :count).by(-1)
      end

      it "should redirect to the league show page" do
        league_id = @teamstat.league.id
        delete :destroy, :id => @teamstat
        response.should redirect_to(league_path(league_id))
      end
      
      it "should only allow destroy when matches = 0 for the league/year"
    end
  end

  describe "POST 'create'" do
    let(:league) { FactoryGirl.create(:league) }
    let(:team) { FactoryGirl.create(:team) }
    before(:each) do
      sign_in(FactoryGirl.create(:user))
    end

    describe "success" do
      let(:attr) { { :team_id => team,  :person_tokens => "1,2" } }

      it "should redirect to the league show page" do
        post :create, :league_id => league, :teamstat => attr
        response.should redirect_to(league_path(league))
      end
      
      it "should have a flash message" do
        post :create, :league_id => league, :teamstat => attr
        flash[:success].should =~ /added/
      end

      it "should change add a roster of people to the teamstat" do
        post :create, :league_id => league, :teamstat => attr
        teamstat = assigns(:teamstat)
        teamstat.reload
        teamstat.rosters.size.should eq(attr[:person_tokens].split(",").size)
      end

    end

    describe "failure" do
      let(:attr) { { :league_id => league } }

      it "should render the 'new' page" do
        post :create, :league_id => league, :teamstat => attr
        response.should render_template('new')        
      end
      
      it "should have the right title" do
        post :create, :league_id => league, :teamstat => attr
        response.should have_selector("title", :content => "New Teamstat")
      end
    end
  end
end