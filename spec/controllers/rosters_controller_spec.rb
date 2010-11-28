require 'spec_helper'

describe RostersController do
 render_views

  describe "DELETE 'destroy'" do
    before(:each) do
      @roster = Factory(:roster)
      test_sign_in(Factory(:user))
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

    end
    
    describe "failure" do
    end

  end  

  describe "POST 'create'" do
    before(:each) do
      @player = Factory(:player)
      @teamstat = Factory(:teamstat)
      test_sign_in(Factory(:user))
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
      #TODO do failure test
    end
  
  end
  
end
