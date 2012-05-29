require 'spec_helper'

describe LeaguesController do
 render_views

  describe "GET 'show'" do
    let(:team1) { FactoryGirl.create(:team) }
    let(:team2) { FactoryGirl.create(:team, :name => "some other name") }
    let(:league) { FactoryGirl.create(:league) }

    it "should show the league's teams" do
      pending "this should be working. This test smells. clean it up and the factory"

        #let(:attr1) { { :points => 5, :wins => 2, :losses => 1,
        #                :ties => 1, :goals_for => 4,
        #                :goals_against => 2, :games_played => 4 } }
        #let(:attr2) { { :points => 1, :wins => 0, :losses => 1,
        #                :ties => 1, :goals_for => 1,
        #                :goals_against => 1, :games_played => 1 } }
        #
        #teamstat1 = Teamstat.create(attr1)
        #teamstat2 = Teamstat.create(attr2)
        #teamstat1.team = team1
        #teamstat2.team = team2
        #teamstat1.league = league
        #teamstat2.league = league
        #teamstat1.save
        #teamstat2.save
        #
        #get :show, :id => league
        #
        ##FIXME - the setup for this should come from a factory now, assuming > 0 matches
        ##FIXME if 0 matches have occurred, it should still display table but with zero state stats
        #response.should have_selector("td", :content => team1.name)
        #response.should have_selector("td", :content => team2.name)
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
      let(:attr) { { :name => "", :year => nil} }

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
      let!(:attr) { { :name => "Some league name", :year => 2002} }

      it "should change the league's attributes" do
        put :update, :id => league, :league => attr
        league = assigns(:league)
        league.reload
        league.name.should eql(attr[:name])
        league.year.should eql(attr[:year])
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
     let(:attr) { { :name => "", :year => "" } }
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
     let(:attr) { { :name => "foo", :year => "2010" } }
     before(:each) do
       sign_in(FactoryGirl.create(:user))
     end

     it "should create a league" do
       lambda do
         post :create, :organization_id => organization, :league => attr
       end.should change(League, :count).by(1)
     end

     it "should redirect to the league show page", :focus => true do
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
    #should require special admin role
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end
end