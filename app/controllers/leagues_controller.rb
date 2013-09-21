class LeaguesController < ApplicationController
  load_and_authorize_resource #requires controller to be RESTful?
  #TODO need to remove lines like -> @league = League.find(params[:id]) 
  # from each method b/c cancan will do it by default?
  before_filter :authenticate_user!, :except => [:show, :index]
  helper_method :sort_column, :sort_direction, :per_page

  def index
    @title = "League Management"
    @leagues = League.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => per_page, :page => params[:page])
  end

  def show
    @league = LeagueDecorator.new(League.find(params[:id]))
    @title = @league.title
  end

  def new
    @title = "New League"
    @league = League.new(:organization_id => params[:organization_id])
  end
  
  def edit
    @league = League.find(params[:id])    
    @title = "Edit league"
  end

  def update
    @league = League.find(params[:id])
    @league.updated_by_id = current_user.id
    if @league.update_attributes(params[:league])
      flash[:success] = "League updated."
      redirect_to @league
    else
      @title = "Edit league"
      render 'edit'
    end    
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @league = @organization.leagues.build(params[:league])
    @league.created_by_id = current_user.id
    @league.updated_by_id = current_user.id
    if @league.save
      flash[:success] = "League created successfully!"
      redirect_to @league
    else 
      @title = "New League"
      render 'new'
    end
  end

  def destroy
    League.find(params[:id]).destroy
    flash[:success] = "League destroyed."
    redirect_to leagues_path
  end

  private

  def sort_column
    League.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
end