require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do
    let(:user) { FactoryGirl.create(:user) }

    describe "for non-signed users" do
      it "should deny access" do
        get :show, :id => user
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
      end
    end

    describe "for signed in users" do
      before(:each) do
        sign_in(user)
      end

      it "should allow admin to view any users roles" do
        get :show, :id => user
        response.should have_selector("div", :content => "Roles")
      end

      it "should be successful" do
        get :show, :id => user
        response.should be_success
      end
      
      it "should find the right user" do
        get :show, :id => user
        assigns(:user).should == user
      end
      
      it "should have the right title" do
        get :show, :id => user
        response.should have_selector("title", :content => user.username)
      end
      
      it "should include the user's name" do
        get :show, :id => user
        response.should have_selector("div", :content => user.username)
      end
    end  
  end

  describe "GET 'index'" do
    describe "for non-signed users" do
      it "should deny access" do
        get :index
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
      end
    end
    
    describe "for signed in users" do
      let!(:admin) { FactoryGirl.create(:user, :username  => "an_admin", :roles => [:admin], :email => FactoryGirl.generate(:email)) }
      let!(:non_admin) { FactoryGirl.create(:user, :username => "regular_user", :roles => [:free], :email => FactoryGirl.generate(:email)) }
      let!(:third) { FactoryGirl.create(:user, :username => FactoryGirl.generate(:username) , :roles => [:free], :email => FactoryGirl.generate(:email)) }
      let!(:users) { [admin, non_admin, third] }

      before(:each) do
        sign_in(admin)
      end

      it "should have an element for each user" do
        get :index
        response.should be_success
        response.should have_selector("title", :content => "All Users")
        users[0..2].each do |user|
          response.should have_selector("td", :content => user.username)
        end
      end
      
      it "should allow searching by role - admin" do
        get :index, :role => :admin
        response.should have_selector("title", :content => "Admin Users")
        response.should have_selector("a", :content => admin.username)
        response.should_not have_selector("a", :content => non_admin.username)
      end

      it "should allow searching by role - disabled" do
        disabled_user = FactoryGirl.create(:user, :username => FactoryGirl.generate(:username) , :roles => [], :email => FactoryGirl.generate(:email))
        get :index, :role => ""
        response.should have_selector("title", :content => "Disabled Users")
        response.should have_selector("a", :content => disabled_user.username)
        response.should_not have_selector("a", :content => non_admin.username)
        response.should_not have_selector("a", :content => admin.username)
      end

      it "should paginate users" do
        8.times do
          users << FactoryGirl.create(:user, :username  => FactoryGirl.generate(:username), :email  => FactoryGirl.generate(:email))
        end

        get :index
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/en/users?page=2",
                                  :content => "2")
        response.should have_selector("a", :href => "/en/users?page=2",
                                  :content => "Next")
      end      
    end    
  end

  describe "GET 'edit'" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
    end
    
    it "should be successful" do
      get :edit, :id => user
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => user
      response.should have_selector("title", :content => "Edit user")
    end

    it "should allow admin to edit any users roles" do
      get :edit, :id => user
      response.should have_selector("label", :content => "Roles")
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
    end

    describe "as a non sign-in user" do
      it "should deny access" do
        delete :destroy, :id => @user
        flash[:error].should =~ /Access Denied/
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
        @non_admin = FactoryGirl.create(:user, :username => FactoryGirl.generate(:username), :email => FactoryGirl.generate(:email), :roles => [:free])
        sign_in(@non_admin)
        delete :destroy, :id => @user
        flash[:error].should =~ /Access Denied/
      end
    end
    
    describe "as an admin user" do
      before(:each) do
        @admin = FactoryGirl.create(:user, :username => FactoryGirl.generate(:username), :email => FactoryGirl.generate(:email))
        sign_in(@admin)
      end

      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end
      
      it "should redirect to the users page" do
        delete :destroy, :id => @user
        response.should redirect_to(users_path)
      end
    end
  end

  describe "PUT 'update'" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in(user)
    end
    
    describe "failure" do
      let(:invalid_attr) { {:email => "", :username => "", :password => "", :password_confirmation => "" } }

      it "should render the 'edit' page" do
        put :update, :id => user, :user => invalid_attr
        response.should render_template('edit')
        response.should have_selector("title", :content => "Edit user")
      end
    end
    
    describe "success" do
      let(:attr) { { :username => "New Name", :email => "user@example.org", :password => "barbaz", :password_confirmation => "barbaz" } }

      it "should change the user's attributes" do
        put :update, :id => user, :user => attr
        user = assigns(:user)
        user.reload
        user.username.should eq(attr[:username])
        user.email.should eq(attr[:email])
        user.password.should eq(attr[:password])
      end

      it "should redirect to the user show page with flash message" do
        put :update, :id => user, :user => attr
        response.should redirect_to(user_path(user))
        flash[:success].should =~ /updated/
      end
    end
  end
end