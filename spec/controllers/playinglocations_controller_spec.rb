require 'spec_helper'

describe PlayinglocationsController do
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
      response.should have_selector("title", :content => "New Playing Location")
    end
  end
  
  # describe "PUT 'update'" do
  #   let(:venue) do
  #     sign_in FactoryGirl.create(:user)
  #     FactoryGirl.create(:venue)
  #   end

  #   describe "failure" do
  #     let(:attr) do
  #       { :name => "", :address1 => ""}
  #     end
      
  #     it "should render the 'edit' page" do
  #       put :update, :id => venue, :venue => attr
  #       response.should render_template('edit')        
  #     end
      
  #     it "should have the right title" do
  #       put :update, :id => venue, :venue => attr
  #       response.should have_selector("title", :content => "Edit Venue")
  #     end
  #   end

  #   describe "success" do
  #     let(:attr) do
  #        { :name => "my stadium", :built => "1984"}
  #     end
      
  #     it "should change the venue's attributes" do
  #       put :update, :id => venue, :venue => attr
  #       venue = assigns(:venue)
  #       venue.reload
  #       venue.name.should eql(attr[:name])
  #       venue.built.should eql(attr[:built])
  #     end
      
  #     it "should redirect to the venue show page" do
  #       put :update, :id => venue, :venue => attr
  #       response.should redirect_to(venue_path(venue))
  #     end
      
  #     it "should have a flash message" do
  #       put :update, :id => venue, :venue => attr
  #       flash[:success].should =~ /updated/
  #     end
  #   end
  # end

  # describe "authentication of venue edit/update pages" do
  #   let(:venue) do
  #     FactoryGirl.create(:venue)
  #   end

  #   describe "for non-signed-in users" do
  #     it "should deny access to 'edit'" do
  #       get :edit, :id => venue
  #       response.should redirect_to(new_user_session_path)
  #     end

  #     it "should deny access to 'update'" do
  #       put :update, :id => venue, :venue => {}
  #       response.should redirect_to(new_user_session_path)
  #     end
  #   end
  # end    

  # describe "GET 'show'" do
  #   let(:venue) do
  #     FactoryGirl.create(:venue)
  #   end
    
  #   it "should be successful" do
  #     get :show, :id => venue
  #     response.should be_success
  #   end
    
  #   it "should find the right venue" do
  #     get :show, :id => venue
  #     assigns(:venue).should == venue
  #   end
    
  #   it "should have the right title" do
  #     get :show, :id => venue
  #     response.should have_selector("title", :content => venue.name)
  #   end
    
  #   it "should include the venue's name" do
  #     get :show, :id => venue
  #     response.should have_selector("h2", :content => venue.name)
  #   end
  # end

  describe "POST 'create'" do
    describe "failure" do
     let(:attr) { {} }
     before(:each) do
       sign_in(FactoryGirl.create(:user))
     end

      describe 'when no teamstat' do
        let(:venue) { FactoryGirl.create(:venue) }
        it "should render a 404" do
          lambda do
            post :create, :teamstat_id => attr, :venue => venue
          end.should raise_error(ActionController::RoutingError)
        end
      end

      describe 'with teamstat and no venue' do
        let(:teamstat) { FactoryGirl.create(:teamstat) }
        it "should not create a playinglocation" do
          lambda do
            post :create, :teamstat_id => teamstat, :venue => attr
          end.should_not change(Playinglocation, :count)
        end
      end
    end
  end
end