require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do
  
    before(:each) do
      @user = Factory(:user)
      sign_in(@user)
    end

    it "should allow admin to edit any users roles"

    it "should not show admin role on registration page - move to request test"
    
        
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.username)    
    end
    
    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.username)
    end

  
  
  end

  
  describe "GET 'index'" do
    
    describe "for non-signed users" do
      it "should deny access" do
        get :index
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /You need to sign in/
      end
    end
    
    describe "for signed in users" do
      before(:each) do
        @user = Factory(:user)
        sign_in(@user)
        second = Factory(:user, :username  => Factory.next(:username), :email => "another@example.com")
        third = Factory(:user, :username  => Factory.next(:username), :email => "another@example.net")
        @users = [@user, second, third]
        8.times do
          @users << Factory(:user, :username  => Factory.next(:username), :email  => Factory.next(:email))
        end
        
      end

      it "should have an element for each user" do
        get :index
        response.should be_success
        response.should have_selector("title", :content => "All Users")
        @users[0..2].each do |user|
          response.should have_selector("td", :content => user.username)
        end
      end
      
      it "should paginate users" do
        get :index
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/users?page=2", 
                                  :content => "2")
        response.should have_selector("a", :href => "/users?page=2", 
                                  :content => "Next")
      end
      
    end
    
  end
  

end
