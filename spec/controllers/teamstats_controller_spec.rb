require 'spec_helper'

describe TeamstatsController do
 render_views

  describe "PUT 'update'" do
      describe "success" do
        it "should change the teamstat's attributes "
      end
  end

  describe "GET 'new'" do
  
    before(:each) do
      @league = FactoryGirl.create(:league)
      sign_in(FactoryGirl.create(:user))
    end
      
    it "should be successful with a league" do
      get :new, :league_id => @league
      response.should be_success
    end

    it "should have the right title" do
      get :new, :league_id => @league
      response.should have_selector("title", :content => "New Teamstat")
    end

  end

  it "should allow the league_table_editor role to override league table settings, ex: docking points"

  describe "GET 'show'" do
  
    before(:each) do
      @roster = FactoryGirl.create(:roster)
    end
      
    it "should be successful with a teamstat(roster)" do
      get :show, :id => @roster.teamstat
      response.should be_success
    end

    it "should have the right title" do
      get :show, :id => @roster.teamstat
      response.should have_selector("title",
          :content => "View Roster | #{@roster.teamstat.league.name} | #{@roster.teamstat.league.year} | #{@roster.teamstat.team.name}")
    end

  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @teamstat = FactoryGirl.create(:teamstat)
      sign_in(FactoryGirl.create(:user))
    end
    
    describe "success" do
      before(:each) do
      end

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
    
    describe "failure" do
    end

  end  

  describe "POST 'create'" do
    before(:each) do
      @league = FactoryGirl.create(:league)
      @team = FactoryGirl.create(:team)
      sign_in(FactoryGirl.create(:user))
    end

    describe "success" do
      before(:each) do
       @attr = { :team_id => @team } 
      end

      it "should redirect to the league show page" do
        post :create, :league_id => @league, :teamstat => @attr
        response.should redirect_to(league_path(@league))
      end
      
      it "should have a flash message" do
        post :create, :league_id => @league, :teamstat => @attr
        flash[:success].should =~ /added/
      end

    end

    describe "failure" do
      before(:each) do
       @attr = { :league_id => @league } 
      end

      it "should render the 'new' page" do
        post :create, :league_id => @league, :teamstat => @attr
        response.should render_template('new')        
      end
      
      it "should have the right title" do
         post :create, :league_id => @league, :teamstat => @attr
       response.should have_selector("title", :content => "New Teamstat")
      end

    end

  end
  
end
