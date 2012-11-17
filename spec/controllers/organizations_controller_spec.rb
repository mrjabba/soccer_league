require 'spec_helper'

describe OrganizationsController do
  render_views

  describe "GET 'new'" do
    before(:each) do
      sign_in FactoryGirl.create(:user)
    end

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "New Organization")
    end
  end

  describe "GET 'edit'" do
    let(:organization) { FactoryGirl.create(:organization) }

    before(:each) do
      sign_in(FactoryGirl.create(:user))
    end

    it "should be successful" do
      get :edit, :id => organization
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => organization
      response.should have_selector("title", :content => "Edit Organization")
    end
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'show'" do
    let(:organization) do
      FactoryGirl.create(:organization)
    end

    it "should be successful" do
      get :show, :id => organization
      response.should be_success
    end

    it "should find the right organization" do
      get :show, :id => organization
      assigns(:organization).should == organization
    end

    it "should have the right title" do
      get :show, :id => organization
      response.should have_selector("title", :content => organization.name)
    end

    it "should include the organization's name" do
      get :show, :id => organization
      response.should have_selector("li", :content => organization.name)
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before { sign_in FactoryGirl.create(:user) }
      let(:attr) { { :name => "", :founded => ""} }

      it "should not create an organization" do
        lambda do
          post :create, :organization => attr
        end.should_not change(Organization, :count)
      end

      it "should have the right title" do
        post :create, :organization => attr
        response.should have_selector("title", :content => "New Organization")
      end

      it "should render the 'new' page" do
        post :create, :organization => attr
        response.should render_template('new')
      end
    end

    describe "success" do
      let(:attr) do
        sign_in FactoryGirl.create(:user)
        { :name => "name", :founded => "1901"}
      end

      it "should create a organization" do
        lambda do
          post :create, :organization => attr
        end.should change(Organization, :count).by(1)
      end

      it "should redirect to the organization show page" do
        post :create, :organization => attr
        response.should redirect_to(organization_path(assigns(:organization)))
      end

      it "should have a flash message" do
        post :create, :organization => attr
        flash[:success].should =~ /Organization created successfully/
      end
    end
  end

  describe "PUT 'update'" do
    let(:organization) do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:organization)
    end

    describe "failure" do
      let(:attr) do
        { :name => "", :founded => ""}
      end

      it "should render the 'edit' page" do
        put :update, :id => organization, :organization => attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => organization, :organization => attr
        response.should have_selector("title", :content => "Edit Organization")
      end
    end

    describe "success" do
      let(:attr) do
        { :name => "name", :founded => 1901}
      end

      it "should change the organization's attributes" do
        put :update, :id => organization, :organization => attr
        organization = assigns(:organization)
        organization.reload
        organization.name.should eql(attr[:name])
        organization.founded.should eql(attr[:founded])
      end

      it "should redirect to the organization show page" do
        put :update, :id => organization, :organization => attr
        response.should redirect_to(organization_path(organization))
      end

      it "should have a flash message" do
        put :update, :id => organization, :organization => attr
        flash[:success].should =~ /updated/
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @organization = FactoryGirl.create(:organization)
      sign_in(FactoryGirl.create(:user))
    end

    describe "success" do
      it "should destroy the organization" do
        lambda do
          delete :destroy, :id => @organization
        end.should change(Organization, :count).by(-1)
      end

      it "should redirect to the organizations page" do
        delete :destroy, :id => @organization
        response.should redirect_to(organizations_path)
      end

      it "should require special admin role"
    end
  end
end