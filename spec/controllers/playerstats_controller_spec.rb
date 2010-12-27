require 'spec_helper'

describe PlayerstatsController do
 render_views

  describe "GET 'new'" do
  
    before(:each) do
      @game = Factory(:game)
      @team = Factory(:team)
      sign_in(Factory(:user))
    end
      
    it "should be successful with a game and a team" do
      get :new, :game_id => @game, :team_id => @team
      response.should be_success
    end

    it "should have the right title" do
      get :new, :game_id => @game, :team_id => @team
      response.should have_selector("title", :content => "New Playerstat")
    end

  end
  

  describe "DELETE 'destroy'" do
    before(:each) do
      @playerstat = Factory(:playerstat)
      sign_in(Factory(:user))
    end
    
    describe "success" do
      before(:each) do
      end

      it "should destroy the playerstat" do
        lambda do 
          delete :destroy, :id => @playerstat
        end.should change(Playerstat, :count).by(-1)
      end

      it "should redirect to the game show page" do
        delete :destroy, :id => @playerstat
        response.should redirect_to(game_path(@playerstat.game))
      end

    end
    
    describe "failure" do
    end

  end    
  

  describe "POST 'create'" do
    before(:each) do
      @game = Factory(:game)
      @team = Factory(:team)
      @player = Factory(:player)
      sign_in(Factory(:user))
    end

    describe "success" do
      before(:each) do
       @attr = { :game_id => @game, :team_id => @team, :player_id => @player } 
      end

      it "should redirect to the game show page" do
        post :create, :playerstat => @attr
        response.should redirect_to(game_path(@game))
      end
      
      it "should have a flash message" do
        post :create, :playerstat => @attr
        flash[:success].should =~ /Player added to game successfully/
      end

    end

    describe "failure" do
      before(:each) do
       @attr = { :game_id => @game, :team_id => @team } 
      end

      it "should render the 'new' page" do
        post :create, :playerstat => @attr
        response.should render_template('new')        
      end
      
      it "should have the right title" do
        post :create, :playerstat => @attr
        response.should have_selector("title", :content => "New Playerstat")
      end

    end

  end

  
end
