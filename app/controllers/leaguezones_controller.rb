class LeaguezonesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  helper_method :sort_column, :sort_direction, :per_page

  def index
    @title = "All Leaguezones"
    @league = League.find_by_id(params[:league_id]) || not_found
    @leaguezones = @league.leaguezones.paginate(:page => params[:page])
  end

  def new
    @title = "New Leaguezone"
    @league = League.find_by_id(params[:league_id]) || not_found
    @leaguezone = Leaguezone.new(:league_id => @league.id)
  end

  def create
    @league = League.find_by_id(params[:league_id]) || not_found

    @leaguezone = @league.leaguezones.build(params[:leaguezone].merge(:created_by_id => current_user.id,
                                                    :updated_by_id => current_user.id))

    if @leaguezone.save
      flash[:success] = "Leaguezone added successfully!"
      redirect_to @leaguezone
    else
      @title = "New Leaguezone"
      render 'new'
    end
  end

  def edit
    @leaguezone = Leaguezone.find_by_id(params[:id]) || not_found
    @league = @leaguezone.league
    @title = "Edit leaguezone"
  end

  def update
    @leaguezone = Leaguezone.find_by_id(params[:id]) || not_found
    @leaguezone.updated_by_id = current_user.id

    if @leaguezone.update_attributes(params[:leaguezone])
      flash[:success] = "leaguezone updated."
      redirect_to @leaguezone
    else
      @title = "Edit leaguezone"
      render 'edit'
    end
  end

  def show
    @leaguezone = Leaguezone.find_by_id(params[:id]) || not_found
    @league = @leaguezone.league
    @title = "View Leaguezone | #{@league.name} | #{@leaguezone.name}"
  end

  def destroy
    @leaguezone = Leaguezone.find_by_id(params[:id]) || not_found
    @leaguezone.destroy
    redirect_to league_leaguezones_path(@leaguezone.league)
  end
end