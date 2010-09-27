require 'spec_helper'

describe TeamsController do
 render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "New Team")
    end
    
  end
  
  describe "GET 'edit'" do
    
    before(:each) do
      @team = Factory(:team)
      test_sign_in(Factory(:user))
    end
    
     it "should be successful" do
      get :edit, :id => @team
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @team
      response.should have_selector("title", :content => "Edit team")
    end
    
  end   
  
  describe "PUT 'update'" do
    before(:each) do
      @team = Factory(:team)
      test_sign_in(Factory(:user))
    end

    describe "failure" do
      before(:each) do
        @attr = { :name => "", :address1 => ""}
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @team, :team => @attr
        response.should render_template('edit')        
      end
      
      it "should have the right title" do
        put :update, :id => @team, :team => @attr
        response.should have_selector("title", :content => "Edit team")
      end
      
    end


    describe "success" do
      before(:each) do
      #  @attr = { :name => "SomeSoccerTeam", :address1 => "123 Main St."}
       @attr = { :name => "Austin Aztex", :address1 => "123 Main St.", 
              :address2 => "Apt A", :city => "Austin", :state => "TX",
              :zip => "78704", :phone => "512-123-4567", :website => "http://foo.com", 
              :email => "test@foo.com" }        
      end
      
      it "should change the team's attributes" do
        put :update, :id => @team, :team => @attr
        team = assigns(:team)
        @team.reload
        @team.name.should  == team.name
        @team.address1.should  == team.address1
      end
      
      it "should redirect to the team show page" do
        put :update, :id => @team, :team => @attr
        response.should redirect_to(team_path(@team))
      end
      
      it "should have a flash message" do
        put :update, :id => @team, :team => @attr
        flash[:success].should =~ /updated/
      end
      
    end


  end
  
 
  
  describe "authentication of team edit/update pages" do

    before(:each) do
      @team = Factory(:team)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @team
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @team, :team => {}
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
