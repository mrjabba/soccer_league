require 'spec_helper'

describe TechnicalstaffsController do
 render_views

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
      response.should have_selector("title", :content => "New Technical Staff")
    end
  end

  describe "POST 'create'" do
    describe 'success' do
      let(:person) { FactoryGirl.create(:person)}
      let(:teamstat) { FactoryGirl.create(:teamstat)}
      let(:attr) { {:person_id => person.id, :teamstat_id => teamstat.id, :role => "Manager"} }
      before(:each) do
        sign_in(FactoryGirl.create(:user))
      end

      it "should create a technicalstaff" do
        lambda do
          post :create, :teamstat_id => teamstat, :technicalstaff => attr
        end.should change(Technicalstaff, :count).by(1)
      end

      it "should redirect to the teamstat show page" do
        post :create, :teamstat_id => teamstat, :technicalstaff => attr
        response.should redirect_to(teamstat_path(assigns(:teamstat)))
      end

      it "should have a flash message" do
        post :create, :teamstat_id => teamstat, :technicalstaff => attr
        flash[:success].should =~ /Staff created successfully/
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
        it "should not create a technicalstaff" do
          lambda do
            post :create, :teamstat_id => teamstat, :person => attr
          end.should_not change(Technicalstaff, :count)
        end
      end
    end


  end

 describe "DELETE 'destroy'" do
   before(:each) do
     @technicalstaff = FactoryGirl.create(:technicalstaff)
     sign_in(FactoryGirl.create(:user))
   end

   describe "success" do
     it "should destroy the technicalstaff" do
       lambda do
         delete :destroy, :id => @technicalstaff
       end.should change(Technicalstaff, :count).by(-1)
     end

     it "should redirect to the playinglocation show page" do
       teamstat_id = @technicalstaff.teamstat_id
       delete :destroy, :id => @technicalstaff
       response.should redirect_to(teamstat_path(teamstat_id))
     end
   end
 end

end