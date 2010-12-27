require 'spec_helper'

describe RostersController do
 render_views

  describe "GET 'new'" do

    before(:each) do
      @teamstat = Factory(:teamstat)
      sign_in(Factory(:user))
    end

    it "should be successful" do
      get 'new', :teamstat_id => @teamstat
      response.should be_success
    end

    it "should have the right title" do
      get 'new', :teamstat_id => @teamstat
      response.should have_selector("title", :content => "New Roster Player")
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @roster = Factory(:roster)
      sign_in(Factory(:user))
    end
    
    describe "success" do
      before(:each) do
      end

      it "should destroy the roster" do
        lambda do 
          delete :destroy, :id => @roster
        end.should change(Roster, :count).by(-1)
      end

      it "should redirect to the teamstat show page" do
        delete :destroy, :id => @roster
        response.should redirect_to(teamstat_path(@roster.teamstat))
      end
      
      it "should only allow destroy when no game stats exist. inactivate roster person?"
 
    end
    
    describe "failure" do
    end

  end  

  describe "POST 'create'" do
    before(:each) do
      @player = Factory(:player)
      @teamstat = Factory(:teamstat)
      sign_in(Factory(:user))
    end

    describe "success" do
      before(:each) do
       @attr = { :teamstat_id => @teamstat, :player_id => @player } 
      end

      it "should redirect to the teamstat (roster) show page" do
        post :create, :roster => @attr
        response.should redirect_to(teamstat_path(@teamstat))
      end
      
      it "should have a flash message" do
        post :create, :roster => @attr
        flash[:success].should =~ /added/
      end

    end

    describe "failure" do

        before(:each) do
          @attr = { :teamstat_id => @teamstat, :player_id => nil} 
        end

        it "should not create a roster" do
          lambda do
            post :create, :roster => @attr
          end.should_not change(Roster, :count)
        end

        it "should have the right title" do
          post :create, :roster => @attr
          response.should have_selector("title", :content => "New Roster Player")
        end

        it "should render the 'new' page" do
          post :create, :roster => @attr
          response.should render_template('new')
        end        
      
    end
  
  end
  
end
