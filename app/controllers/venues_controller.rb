class VenuesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  helper_method :sort_column, :sort_direction, :per_page

  def index
    if params[:q]
      respond_to do |format|
        format.json { render :json => Venue.fetch_venues_by_name_as_array(params[:q])}
      end
    else
      @title = "Venue Repository"
      @venues = Venue.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => per_page, :page => params[:page])
    end
  end

  def show
    @venue = Venue.find(params[:id]) 
    @title = "View Venue | " + @venue.name
  end

  def edit
    @venue = Venue.find(params[:id])
    @title = "Edit Venue"
  end

  def update
    @venue = Venue.find(params[:id])
    @venue.updated_by_id = current_user.id
    if @venue.update_attributes(params[:venue])
      flash[:success] = "Venue updated."
      redirect_to @venue
    else
      @title = "Edit venue"
      render 'edit'
    end    
  end

  def new
    @title = "New Venue"
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(params[:venue])
    @venue.created_by_id = current_user.id
    @venue.updated_by_id = current_user.id
    if @venue.save
      flash[:success] = "Venue created successfully!"
      redirect_to @venue
    else 
      @title = "New Venue"
      render 'new'
    end
  end 

  private

    def sort_column
      Venue.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
end
