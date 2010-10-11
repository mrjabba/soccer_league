require 'spec_helper'

describe PlayersController do
 render_views
 
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "New Player")
    end
  end

  describe "GET 'edit'" do
    
    before(:each) do
      @player = Factory(:player)
      test_sign_in(Factory(:user))
    end
    
     it "should be successful" do
      get :edit, :id => @player
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @player
      response.should have_selector("title", :content => "Edit player")
    end
    
    
  end
  
  describe "PUT 'update'" do
    before(:each) do
      @player = Factory(:player)
      test_sign_in(Factory(:user))
    end
    
    describe "failure" do
      before(:each) do
        @attr = { :firstname => "", :lastname => "", :position => ""}
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @player, :player => @attr
        response.should render_template('edit')        
      end
      
      it "should have the right title" do
        put :update, :id => @player, :player => @attr
        response.should have_selector("title", :content => "Edit player")
      end
      
    end
    
    describe "success" do
      before(:each) do
        #@attr = { :firstname => "John", :lastname => "Doe", :position => "Defender"}
        @attr = { :firstname => "Jamie", :lastname => "Watson", :position => "Forward" , 
        :jersey_number => 10, :birth_date => "02/10/1978", :nationality => "USA", 
        :previous_club => "Real Salt Lake"}
        
      end
      
      it "should change the player's attributes" do
        put :update, :id => @player, :player => @attr
        player = assigns(:player)
        @player.reload
        @player.firstname.should  == player.firstname
        @player.lastname.should  == player.lastname
        @player.position.should  == player.position
        @player.jersey_number.should  == player.jersey_number
        @player.birth_date.should  == player.birth_date
        @player.nationality.should  == player.nationality
        @player.previous_club.should  == player.previous_club
      end
      
      it "should redirect to the player show page" do
        put :update, :id => @player, :player => @attr
        response.should redirect_to(player_path(@player))
      end
      
      it "should have a flash message" do
        put :update, :id => @player, :player => @attr
        flash[:success].should =~ /updated/
      end
      
    end
    
     
    
  end
  
  describe "authentication of player edit/update pages" do

    before(:each) do
      @player = Factory(:player)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @player
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @player, :player => {}
        response.should redirect_to(signin_path)
      end
    end
  end  
  
  describe "GET 'index'" do
  
    it "should be successful" do
      get :index
      response.should be_success
    end

  end

  describe "GET 'show'" do
  
    before(:each) do
      @player = Factory(:player)
    end
    
    it "should be successful" do
      get :show, :id => @player
      response.should be_success
    end
    
    it "should find the right player" do
      get :show, :id => @player
      assigns(:player).should == @player
    end
    
    it "should have the right title" do
      get :show, :id => @player
      response.should have_selector("title", :content => @player.firstname)    
    end
    
    it "should include the team's player" do
      get :show, :id => @player
      response.should have_selector("h1", :content => @player.firstname)
    end
  
  end




  describe "POST 'create'" do
      describe "failure" do
      end
      describe "success" do
      end

  end
  
  describe "DELETE 'destroy'" do
    #should require special admin role
  end



end
