class PlayersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  helper_method :sort_column, :sort_direction, :per_page

  def index
    if params[:q]
      respond_to do |format|
        format.json { render :json => Player.fetch_players_by_first_name_as_array(params[:q])}
      end
    else
      @title = "Player Repository"
      @players = Player.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => per_page, :page => params[:page])
    end
  end

  def show
    @player = Player.find(params[:id])
    @playerstats = Playerstat.find_all_by_player_id(params[:id])
    @title = "View Player | " + @player.firstname + " " + @player.lastname
  end

  def edit
    @player = Player.find(params[:id])
    @title = "Edit player"
  end
  
  def update
    @player = Player.find(params[:id])
    @player.updated_by_id = current_user.id
    if @player.update_attributes(params[:player])
      flash[:success] = "Player updated."
      redirect_to @player
    else
      @title = "Edit player"
      render 'edit'
    end    
  end
  
  def new
    @title = "New Player"
    @player = Player.new
  end
  
  def create
    @player = Player.new(params[:player])
    @player.created_by_id = current_user.id
    @player.updated_by_id = current_user.id
    if @player.save
      flash[:success] = "Player created successfully!"
      redirect_to @player
    else 
      @title = "New Player"
      render 'new'
    end
  end    

  private

    def sort_column
      Player.column_names.include?(params[:sort]) ? params[:sort] : "lastname"
    end
end
