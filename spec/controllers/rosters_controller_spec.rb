require 'spec_helper'

describe RostersController do
  render_views

 describe "GET 'show'" do
   let(:roster) do
     FactoryGirl.create(:roster)
   end

   it "should be successful" do
     get :show, :id => roster
     response.should be_success
   end

   it "should find the right roster" do
     get :show, :id => roster
     assigns(:roster).should == roster
   end

   it "should have the right title" do
     get :show, :id => roster
     response.should have_selector("title", :content => "View Roster")
   end
 end

  describe "GET 'new'" do
    let(:teamstat) do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:teamstat)
    end

    it "should be successful" do
      get 'new', :teamstat_id => teamstat
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new', :teamstat_id => teamstat
      response.should have_selector("title", :content => "New Roster Item")
    end
  end

  describe "POST 'create'" do
    describe 'success' do
      let(:person) { FactoryGirl.create(:person)}
      let(:teamstat) { FactoryGirl.create(:teamstat)}
      let(:attr) { {:person_id => person.id, :teamstat_id => teamstat.id} }
      before(:each) do
        sign_in(FactoryGirl.create(:user))
      end

      it "should create a roster" do
        lambda do
          post :create, :teamstat_id => teamstat, :roster => attr
        end.should change(Roster, :count).by(1)
      end

      it "should redirect to the teamstat show page" do
          post :create, :teamstat_id => teamstat, :roster => attr
        response.should redirect_to(teamstat_path(assigns(:teamstat)))
      end

      it "should have a flash message" do
          post :create, :teamstat_id => teamstat, :roster => attr
        flash[:success].should =~ /Roster item created successfully!/
      end
    
    end

    describe "failure" do
     let(:attr) { {} }
     before(:each) do
       sign_in(FactoryGirl.create(:user))
     end

      describe 'when no teamstat' do
        let(:person) { FactoryGirl.create(:person) }
        it "should render a 404" do
          lambda do
            post :create, :teamstat_id => attr, :person => person
          end.should raise_error(ActionController::RoutingError)
        end
      end

      describe 'with teamstat and no person' do
        let(:teamstat) { FactoryGirl.create(:teamstat) }
        it "should not create a roster" do
          lambda do
            post :create, :teamstat_id => teamstat, :person => attr
          end.should_not change(Roster, :count)
        end
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @roster = FactoryGirl.create(:roster)
      sign_in(FactoryGirl.create(:user))
    end

    describe "success" do
      it "should destroy the roster" do
        lambda do
          delete :destroy, :id => @roster
        end.should change(Roster, :count).by(-1)
      end

      it "should redirect to the teamstat show page" do
        teamstat_id = @roster.teamstat_id
        delete :destroy, :id => @roster
        response.should redirect_to(teamstat_path(teamstat_id))
      end
    end
  end

end