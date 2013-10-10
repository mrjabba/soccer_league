require 'spec_helper'

describe LeaguezonesController do
 render_views

 describe "GET 'show'" do
   let(:leaguezone) do
     FactoryGirl.create(:leaguezone)
   end

   it "should be successful" do
     get :show, :id => leaguezone
     response.should be_success
   end

   it "should find the right leaguezone" do
     get :show, :id => leaguezone
     assigns(:leaguezone).should == leaguezone
   end

   it "should have the right title" do
     get :show, :id => leaguezone
     response.should have_selector("title", :content => leaguezone.name)
   end

   it "should include the leaguezone's name" do
     get :show, :id => leaguezone
     response.should have_selector("li", :content => leaguezone.name)
   end
 end

 describe "GET 'new'" do
   let(:league) do
     sign_in(FactoryGirl.create(:user))
     FactoryGirl.create(:league)
   end

   it "should be successful" do
     get :new, :league_id => league
     response.should be_success
   end

    it "should have the right title" do
      get :new, :league_id => league
      response.should have_selector("title", :content => "New Leaguezone")
    end
  end

  describe "GET 'edit'" do
    let(:leaguezone) { FactoryGirl.create(:leaguezone) }

    before(:each) do
      sign_in(FactoryGirl.create(:user))
    end
    
    it "should be successful" do
      get :edit, :id => leaguezone
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => leaguezone
      response.should have_selector("title", :content => "Edit leaguezone")
    end
  end

  describe "PUT 'update'" do
    let(:leaguezone) do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:leaguezone)
    end
    
    describe "failure" do
      let(:attr) { { :name => "", :start_rank => nil} }

      it "should render the 'edit' page" do
        put :update, :id => leaguezone, :leaguezone => attr
        response.should render_template('edit')        
      end
      
      it "should have the right title" do
        put :update, :id => leaguezone, :leaguezone => attr
        response.should have_selector("title", :content => "Edit leaguezone")
      end
    end
    
    describe "success" do
      let(:attr) { { :name => "Some leaguezone name", :start_rank => 15} }

      it "should change the leaguezone's attributes" do
        put :update, :id => leaguezone, :leaguezone => attr
        leaguezone = assigns(:leaguezone)
        leaguezone.reload
        leaguezone.name.should eql(attr[:name])
        leaguezone.start_rank.should eql(attr[:start_rank])
      end
      
      it "should redirect to the league show page" do
        put :update, :id => leaguezone, :leaguezone => attr
        response.should redirect_to(leaguezone_path(leaguezone))
      end
      
      it "should have a flash message" do
        put :update, :id => leaguezone, :leaguezone => attr
        flash[:success].should =~ /updated/
      end
    end
  end

 describe "POST 'create'" do
   let(:league) { FactoryGirl.create(:league) }

   describe "failure" do
     let(:attr) { { :name => "", :start_rank => "" } }
     before(:each) do
       sign_in(FactoryGirl.create(:user))
     end

     it "should not create a leaguezone" do
       lambda do
         post :create, :league_id => league, :leaguezone => attr
       end.should_not change(Leaguezone, :count)
     end

     it "should have the right title" do
       post :create, :league_id => league, :leaguezone => attr
       response.should have_selector("title", :content => "New Leaguezone")
     end

     it "should render the 'new' page" do
       post :create, :league_id => league, :leaguezone => attr
       response.should render_template('new')
     end
   end

   describe "success" do
     let(:attr) { { :name => "foo", :start_rank => "3", :end_rank => "5", 
       :style => "style" } }
     before(:each) do
       sign_in(FactoryGirl.create(:user))
     end

     it "should create a league" do
       lambda do
         post :create, :league_id => league, :leaguezone => attr
       end.should change(Leaguezone, :count).by(1)
     end

     it "should redirect to the league show page" do
       post :create, :league_id => league, :leaguezone => attr
       response.should redirect_to(leaguezone_path(assigns(:leaguezone)))
     end

     it "should have a flash message" do
       post :create, :league_id => league, :leaguezone => attr
       flash[:success].should =~ /Leaguezone added successfully!/
     end
   end
 end

 describe "DELETE 'destroy'" do
   before(:each) do
     @leaguezone = FactoryGirl.create(:leaguezone)
     sign_in(FactoryGirl.create(:user))
   end

   describe "success" do
     it "should destroy the leaguezone" do
       lambda do
         delete :destroy, :id => @leaguezone
       end.should change(Leaguezone, :count).by(-1)
     end

     it "should redirect to the league/leaguezone show page" do
       league_id = @leaguezone.league_id
       delete :destroy, :id => @leaguezone
       response.should redirect_to(league_leaguezones_path(league_id))
     end
   end
 end

 describe "GET 'index'" do
    it "should be successful" do
      league = FactoryGirl.create(:league)
      get :index, :league_id => league
      response.should be_success
    end
  end
end