require 'spec_helper'

describe LeaguesController do
 render_views

 describe "GET 'show'" do
   let(:league) do
     FactoryGirl.create(:league)
   end

   it "should be successful" do
     get :show, :id => league
     response.should be_success
   end

   it "should find the right league" do
     get :show, :id => league
     assigns(:league).should == league
   end

   it "should have the right title" do
     get :show, :id => league
     response.should have_selector("title", :content => league.name)
   end

   it "should include the league's name" do
     get :show, :id => league
     response.should have_selector("li", :content => league.name)
   end
 end

 describe "GET 'new'" do
    #TODO I dont think this checks for failure. need a test without an organization
   let(:organization) do
     sign_in(FactoryGirl.create(:user))
     FactoryGirl.create(:organization)
   end

   it "should be successful" do
     get :new, :organization_id => organization
     response.should be_success
   end

    it "should have the right title" do
      get :new, :organization_id => organization
      response.should have_selector("title", :content => "New League")
    end
  end

  describe "GET 'edit'" do
    let(:league) { FactoryGirl.create(:league) }

    before(:each) do
      sign_in(FactoryGirl.create(:user))
    end
    
    it "should be successful" do
      get :edit, :id => league
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => league
      response.should have_selector("title", :content => "Edit league")
    end
  end

  describe "PUT 'update'" do
    let(:league) { FactoryGirl.create(:league) }

    before(:each) do
      sign_in(FactoryGirl.create(:user))
    end
    
    describe "failure" do
      let(:attr) { { :name => "", :from_year => nil} }

      it "should render the 'edit' page" do
        put :update, :id => league, :league => attr
        response.should render_template('edit')        
      end
      
      it "should have the right title" do
        put :update, :id => league, :league => attr
        response.should have_selector("title", :content => "Edit league")
      end
    end
    
    describe "success" do
      let!(:attr) { { :name => "Some league name", :from_year => 2002} }

      it "should change the league's attributes" do
        put :update, :id => league, :league => attr
        league = assigns(:league)
        league.reload
        league.name.should eql(attr[:name])
        league.from_year.should eql(attr[:from_year])
      end
      
      it "should redirect to the league show page" do
        put :update, :id => league, :league => attr
        response.should redirect_to(league_path(league))
      end
      
      it "should have a flash message" do
        put :update, :id => league, :league => attr
        flash[:success].should =~ /updated/
      end
    end
  end

 describe "POST 'create'" do
   let(:organization) { FactoryGirl.create(:organization) }

   describe "failure" do
     let(:attr) { { :name => "", :from_year => "" } }
     before(:each) do
       sign_in(FactoryGirl.create(:user))
     end

     it "should not create a league" do
       lambda do
         post :create, :organization_id => organization, :league => attr
       end.should_not change(League, :count)
     end

     it "should have the right title" do
       post :create, :organization_id => organization, :league => attr
       response.should have_selector("title", :content => "New League")
     end

     it "should render the 'new' page" do
       post :create, :organization_id => organization, :league => attr
       response.should render_template('new')
     end
   end

   describe "success" do
     let(:attr) { { :name => "foo", :from_year => "2010", :to_year => "2011" } }
     before(:each) do
       sign_in(FactoryGirl.create(:user))
     end

     it "should create a league" do
       lambda do
         post :create, :organization_id => organization, :league => attr
       end.should change(League, :count).by(1)
     end

     it "should redirect to the league show page" do
       post :create, :organization_id => organization, :league => attr
       response.should redirect_to(league_path(assigns(:league)))
     end

     it "should have a flash message" do
       post :create, :organization_id => organization, :league => attr
       flash[:success].should =~ /League created successfully/
     end
   end
 end

 describe "DELETE 'destroy'" do
   before(:each) do
     @league = FactoryGirl.create(:league)
     sign_in(FactoryGirl.create(:user))
   end

   describe "success" do
     it "should destroy the league" do
       lambda do
         delete :destroy, :id => @league
       end.should change(League, :count).by(-1)
     end

     it "should redirect to the organization show page" do
       delete :destroy, :id => @league
       response.should redirect_to(leagues_path)
     end

     it "should require special admin role"
   end
 end

 describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end
end