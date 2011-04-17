class PlayersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  helper_method :sort_column, :sort_direction

  def index
    @title = "Player Repository"
    @players = Player.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
    
    if params[:q]
      @json_players = Player.where("firstname like ?", "%#{params[:q]}%") 
      respond_to do |format|
        format.html
        format.json { render :json => @json_players.map(&:fields)}
      end
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

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end


end
