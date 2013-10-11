require 'spec_helper'

describe GamesController do
 render_views

  let(:user) { FactoryGirl.create(:user) }

  describe "GET 'index'" do
    before(:each) do
      @league = FactoryGirl.create(:league)
    end
  
    it "should require a league and be successful" do
      get :index, :league_id => @league
      response.should be_success
    end

    it "should have the right title" do
      get :index, :league_id => @league
      response.should have_selector("title", :content => "All games")
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @playerstat = FactoryGirl.create(:playerstat)
      @game = @playerstat.game
    end
  
    describe "unauthenticated user" do
      before(:each) do
        get :edit, :id => @game
      end

      it "should redirect to login screen" do
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "authenticated user" do 
      before(:each) do
        sign_in(user)
        get :edit, :id => @game
      end

      it "should display game edit screen" do
        response.should be_success
        response.should have_selector("title", :content => "Edit game")
      end
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @playerstat = FactoryGirl.create(:playerstat)
      @game = @playerstat.game
    end

    describe "unauthenticated user" do
      before(:each) do
        get :show, :id => @game
      end

      it "should find the right game" do
        response.should be_success
        assigns(:game).should == @game
      end
      
      it "should include the both teams in a table and the title" do
        response.should have_selector("title", :content => "#{@game.visiting_team_name} at #{@game.home_team_name}")
        response.should have_selector("td", :content => @game.visiting_team_name)
        response.should have_selector("td", :content => @game.home_team_name)
      end
    end
    
    describe "authenticated user" do
      before(:each) do
        sign_in(user)
        get :show, :id => @game
      end
      
      it "should include a remove links for game and people when game is not completed" do
        response.should have_selector("a", :id => "remove_game")
        response.should have_selector("a", :id => "remove_person")
      end
    end
  end

  describe "GET 'new'" do
    before(:each) do
      @league = FactoryGirl.create(:league)
      sign_in(user)
    end
  
    describe "success" do
      it "should require a league and be successful" do
        get :new, :league_id => @league
        response.should be_success
      end

      it "should have the right title" do
        get :new, :league_id => @league
        response.should have_selector("title", :content => "New Game")
      end
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @league = FactoryGirl.create(:league)
      @teamstat_home = FactoryGirl.create(:teamstat)
      @teamstat_visitor = FactoryGirl.create(:teamstat)
      sign_in(user)
    end

    describe "success" do
      before(:each) do
        @attr = { :league_id => @league, :teamstat1_id => @teamstat_home, :teamstat2_id => @teamstat_visitor } 
      end

      it "should redirect to the game show page" do
        post :create, :league_id => @league.id, :game => @attr
        response.should redirect_to(game_path(Game.first.id))
      end

      it "should create a game" do
        lambda do
          post :create, :league_id => @league.id, :game => @attr
        end.should change(Game, :count).by(1)
      end

      it "should have a flash message" do
        post :create, :league_id => @league.id, :game => @attr
        flash[:success].should =~ /added/
      end
    end

    describe "failure" do
      before(:each) do
        @league = FactoryGirl.create(:league)
        @attr = { :teamstat1_id => nil } 
      end

      it "should render the 'edit' page" do
        post :create, :league_id => @league.id, :game => @attr
        response.should render_template('new')        
      end
      
      it "should have the right title" do
        post :create, :league_id => @league.id, :game => @attr
        response.should have_selector("title", :content => "New Game")
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    before(:each) do
      @game = FactoryGirl.create(:game)
      sign_in(user)
    end
    
    describe "success" do
      it "should destroy the game" do
        lambda do
          delete :destroy, :id => @game
        end.should change(Game, :count).by(-1)
      end

      it "should redirect to the league's view games page" do
        delete :destroy, :id => @game
        response.should redirect_to(league_games_path(@game.league))
      end
    end
  end
end