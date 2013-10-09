class PeopleController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  helper_method :sort_column, :sort_direction, :per_page

  def index
    if params[:q]
      respond_to do |format|
        format.json { render :json => Person.fetch_people_by_first_name_as_array(params[:q])}
      end
    else
      @title = "Person Repository"
      @people = Person.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => per_page, :page => params[:page])
    end
  end

  def show
    @person = Person.find(params[:id])
    @title = "View Person | " + @person.firstname + " " + @person.lastname
  end

  def edit
    @person = Person.find(params[:id])
    @title = "Edit Person"
  end
  
  def update
    @person = Person.find(params[:id])
    @person.updated_by_id = current_user.id
    if @person.update_attributes(params[:person])
      flash[:success] = "Person updated."
      redirect_to @person
    else
      @title = "Edit Person"
      render 'edit'
    end    
  end
  
  def new
    @title = "New Person"
    @person = Person.new
  end
  
  def create
    @person = Person.new(params[:person])
    @person.created_by_id = current_user.id
    @person.updated_by_id = current_user.id
    if @person.save
      @graph = OpenGraph.new(@person)
      @graph.post_new_model(request, session)
      flash[:success] = "Person created successfully!"
      redirect_to @person
    else 
      @title = "New Person"
      render 'new'
    end
  end    

  private

    def sort_column
      Person.column_names.include?(params[:sort]) ? params[:sort] : "lastname"
    end
end
