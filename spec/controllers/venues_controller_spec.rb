require 'spec_helper'

describe VenuesController do
 render_views

  describe "GET 'new'" do
    before(:each) do
      sign_in FactoryGirl.create(:user)
    end

    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "New Venue")
    end
  end
  
  describe "GET 'edit'" do
    let(:venue) do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:venue)
    end
    
     it "should be successful" do
      get :edit, :id => venue
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => venue
      response.should have_selector("title", :content => "Edit Venue")
    end
  end   
  
  describe "PUT 'update'" do
    let(:venue) do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:venue)
    end

    describe "failure" do
      let(:attr) do
        { :name => ""}
      end
      
      it "should render the 'edit' page" do
        put :update, :id => venue, :venue => attr
        response.should render_template('edit')        
      end
      
      it "should have the right title" do
        put :update, :id => venue, :venue => attr
        response.should have_selector("title", :content => "Edit venue")
      end
    end

    describe "success" do
      let(:attr) do
         { :name => "some field"}
      end
      
      it "should change the venue's attributes" do
        put :update, :id => venue, :venue => attr
        venue = assigns(:venue)
        venue.reload
        venue.name.should eql(attr[:name])
      end
      
      it "should redirect to the venue show page" do
        put :update, :id => venue, :venue => attr
        response.should redirect_to(venue_path(venue))
      end
      
      it "should have a flash message" do
        put :update, :id => venue, :venue => attr
        flash[:success].should =~ /updated/
      end
    end
  end

  describe "authentication of venue edit/update pages" do
    let(:venue) do
      FactoryGirl.create(:venue)
    end

    describe "for non-signed-in users" do
      it "should deny access to 'edit'" do
        get :edit, :id => venue
        response.should redirect_to(new_user_session_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => venue, :venue => {}
        response.should redirect_to(new_user_session_path)
      end
    end
  end    

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'show'" do
    let(:venue) do
      FactoryGirl.create(:venue)
    end
    
    it "should be successful" do
      get :show, :id => venue
      response.should be_success
    end
    
    it "should find the right venue" do
      get :show, :id => venue
      assigns(:venue).should == venue
    end
    
    it "should have the right title" do
      get :show, :id => venue
      response.should have_selector("title", :content => venue.name)
    end
    
    it "should include the venue's name" do
      get :show, :id => venue
      response.should have_selector("h1", :content => venue.name)
    end
  end

  describe "POST 'create'" do
      describe "failure" do
        before {sign_in FactoryGirl.create(:user)}
        let(:attr) { { :name => ""}}
        it "should not create a venue" do
          lambda do
            post :create, :venue => attr
          end.should_not change(Venue, :count)
        end

        it "should have the right title" do
          post :create, :venue => attr
          response.should have_selector("title", :content => "New Venue")
        end

        it "should render the 'new' page" do
          post :create, :venue => attr
          response.should render_template('new')
        end  
      end
      
      describe "success" do
        let(:attr) do
          sign_in FactoryGirl.create(:user)
          { :name => "name"}
        end

        it "should create a venue" do
          lambda do
            post :create, :venue => attr
          end.should change(Venue, :count).by(1)
        end

        it "should redirect to the venue show page" do
          post :create, :venue => attr
          response.should redirect_to(venue_path(assigns(:venue)))
        end   
        
        it "should have a flash message" do
          post :create, :venue => attr
          flash[:success].should =~ /Venue created successfully/
        end
      end
  end
end