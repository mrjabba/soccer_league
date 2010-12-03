require 'spec_helper'

describe TeamstatsController do
 render_views

  describe "GET 'new'" do
  
    before(:each) do
      @league = Factory(:league)
      test_sign_in(Factory(:user))
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

  describe "GET 'show'" do
  
    before(:each) do
      @roster = Factory(:roster)
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
      @teamstat = Factory(:teamstat)
      test_sign_in(Factory(:user))
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
        delete :destroy, :id => @teamstat
        response.should redirect_to(league_path(@league))
      end

    end
    
    describe "failure" do
    end

  end  

  describe "POST 'create'" do
    before(:each) do
      @league = Factory(:league)
      @team = Factory(:team)
      test_sign_in(Factory(:user))
    end

    describe "success" do
      before(:each) do
       @attr = { :league_id => @league, :team_id => @team } 
      end

      it "should redirect to the league show page" do
        post :create, :teamstat => @attr
        response.should redirect_to(league_path(@league))
      end
      
      it "should have a flash message" do
        post :create, :teamstat => @attr
        flash[:success].should =~ /added/
      end

    end

    describe "failure" do
      before(:each) do
       @attr = { :league_id => @league } 
      end

      it "should render the 'new' page" do
        post :create, :teamstat => @attr
        response.should render_template('new')        
      end
      
      it "should have the right title" do
        post :create, :teamstat => @attr
        response.should have_selector("title", :content => "New Teamstat")
      end

    end

  end
  
end
