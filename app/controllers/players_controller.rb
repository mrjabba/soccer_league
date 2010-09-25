class PlayersController < ApplicationController

  def show
    @player = Player.find(params[:id])
  end
  

  def new
    @title = "Players"
  end

end
