require 'spec_helper'

describe TeamstatsController do
 render_views
=begin
    describe "GET 'new'" do
      it "should be successful" do
        get 'new'
        response.should be_success
      end

      it "should have the right title" do
        get 'new'
        response.should have_selector("title", :content => "New Teamstat")
      end
    end
=end
    
  describe "GET 'edit'" do
    
    before(:each) do
      @teamstat = Factory(:teamstat)
      test_sign_in(Factory(:user))
    end
    
     it "should be successful" do
      get :edit, :id => @teamstat
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @teamstat
      response.should have_selector("title", :content => "Edit teamstat")
    end
    
    
  end

 describe "PUT 'update'" do
    before(:each) do
      @teamstat = Factory(:teamstat)
      test_sign_in(Factory(:user))
    end
    
    describe "failure" do
      before(:each) do
        @attr = { :points => nil, :wins => nil, :losses => nil, 
          :ties => nil, :goals_for => nil, 
          :goals_against => nil, :games_played => nil }
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @teamstat, :teamstat => @attr
        response.should render_template('edit')        
      end
      
      it "should have the right title" do
        put :update, :id => @teamstat, :teamstat => @attr
        response.should have_selector("title", :content => "Edit teamstat")
      end
      
    end
    
    describe "success" do
      before(:each) do
        @attr = { :points => 5, :wins => 2, :losses => 1, 
          :ties => 1, :goals_for => 4, 
          :goals_against => 2, :games_played => 4 }
        
      end
      
      it "should change the teamstat's attributes" do
        put :update, :id => @teamstat, :teamstat => @attr
        teamstat = assigns(:teamstat)
        @teamstat.reload
        @teamstat.points.should  == teamstat.points
        @teamstat.wins.should  == teamstat.wins
        @teamstat.losses.should  == teamstat.losses
        @teamstat.ties.should  == teamstat.ties
        @teamstat.goals_for.should  == teamstat.goals_for
        @teamstat.goals_against.should  == teamstat.goals_against
        @teamstat.games_played.should  == teamstat.games_played
      end
      
      it "should redirect to the teamstat show page" do
        put :update, :id => @teamstat, :teamstat => @attr
        #TODO, this will prob fail
        response.should redirect_to(teamstat_path(@teamstat))
      end
      
      it "should have a flash message" do
        put :update, :id => @teamstat, :teamstat => @attr
        flash[:success].should =~ /updated/
      end
      
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
