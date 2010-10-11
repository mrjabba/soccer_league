class PlayersController < ApplicationController
#FIXME add create and new to authenticate
  before_filter :authenticate, :only => [:edit, :update]

  def index
    @title = "All players"
    @players = Player.paginate(:page => params[:page])
  end

  def show
    @player = Player.find(params[:id])
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
    if @player.save
      flash[:success] = "Player created successfully!"
      redirect_to @player
      #redirect_to user_path(@user)
    else 
      @title = "New Player"
      render 'new'
    end
  end  
  

  private

    def authenticate
      deny_access unless signed_in?
    end

end
