require 'spec_helper'

describe PeopleController do
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
      response.should have_selector("title", :content => "New Person")
    end
  end

  describe "GET 'edit'" do
    let(:person) do
      sign_in(FactoryGirl.create(:user, :email => FactoryGirl.generate(:email)))
      FactoryGirl.create(:person)
    end
    
     it "should be successful" do
      get :edit, :id => person
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => person
      response.should have_selector("title", :content => "Edit Person")
    end
  end

  describe "PUT 'update'" do
    let(:person) do
      sign_in(FactoryGirl.create(:user, :email => FactoryGirl.generate(:email)))
      FactoryGirl.create(:person)
    end
    
    describe "failure" do
      let(:attr) { { :firstname => "", :lastname => "", :position => "" } }

      it "should render the 'edit' page" do
        put :update, :id => person, :person => attr
        response.should render_template('edit')        
      end
      
      it "should have the right title" do
        put :update, :id => person, :person => attr
        response.should have_selector("title", :content => "Edit Person")
      end
    end
    
    describe "success" do
      let(:attr) do
        { :firstname => "Jamie", :lastname => "Watson", :position => Person::POSITIONS.values.first,
        :birth_date => "02/10/1978", :nationality => "USA", :height_feet => "5", :height_inches => "8"}
      end
      
      it "should change the person's attributes" do
        put :update, :id => person, :person => attr
        person = assigns(:person)
        person.reload
        person.firstname.should eql(attr[:firstname])
        person.lastname.should eql(attr[:lastname])
        person.position.should eql(attr[:position])
        person.birth_date.should eql(Date.parse(attr[:birth_date]))
        person.nationality.should eql(attr[:nationality])
        person.height.should be_within(0.05).of(1.73)
      end
      
      it "should redirect to the person show page" do
        put :update, :id => person, :person => attr
        response.should redirect_to(person_path(person))
      end
      
      it "should have a flash message" do
        put :update, :id => person, :person => attr
        flash[:success].should =~ /updated/
      end
    end
  end
  
  describe "authentication of person edit/update pages" do
    let(:person) { FactoryGirl.create(:person) }

    describe "for non-signed-in users" do
      it "should deny access to 'edit'" do
        get :edit, :id => person
        response.should redirect_to(new_user_session_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => person, :person => {}
        response.should redirect_to(new_user_session_path)
      end
    end
  end  
  
  describe "GET 'index'" do
    let!(:person) { FactoryGirl.create(:person) }
    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should support querying for person tokens" do
      expected = [{:id => person.id, :name => person.name}].to_json
      get :index, :q => person.name[0], :format => "json"
      response.body.should eq(expected)
    end
  end

  describe "GET 'show'" do
    let(:person) {FactoryGirl.create(:person)}

    it "should be successful" do
      get :show, :id => person
      response.should be_success
    end
    
    it "should find the right person" do
      get :show, :id => person
      assigns(:person).should == person
    end
    
    it "should have the right title" do
      get :show, :id => person
      response.should have_selector("title", :content => person.firstname)
    end
    
    it "should include the team's person" do
      get :show, :id => person
      response.should have_selector("h1", :content => person.firstname)
    end
    
    it "should roll up playerstats in a league/year calculation for person show page"

    it "should calculate person previous club based on past teamstat or roster."
  end

  describe "POST 'create'" do
      describe "failure" do
        let(:attr) do
          sign_in FactoryGirl.create(:user)
          { :firstname => "", :lastname => "", :position => "" }
        end

        it "should not create a person" do
          lambda do
            post :create, :person => attr
          end.should_not change(Person, :count)
        end

        it "should have the right title" do
          post :create, :person => attr
          response.should have_selector("title", :content => "New Person")
        end

        it "should render the 'new' page" do
          post :create, :person => attr
          response.should render_template('new')
        end   
      end

      describe "success" do
        let(:attr) do
          sign_in FactoryGirl.create(:user)
          { :firstname => "first", :lastname => "last", :position => Person::POSITIONS.values.first, :birth_date => "02/10/1978" }
        end

        it "should create a person" do
          lambda do
            post :create, :person => attr
          end.should change(Person, :count).by(1)
        end

        it "should redirect to the person show page" do
          post :create, :person => attr
          response.should redirect_to(person_path(assigns(:person)))
        end   

        it "should save the person's attributes" do
          post :create, :person => attr
          person = assigns(:person)
          person.birth_date.should_not == nil
        end
        
        it "should have a flash message" do
          post :create, :person => attr
          flash[:success].should =~ /Person created successfully/
        end
      end
  end
end
