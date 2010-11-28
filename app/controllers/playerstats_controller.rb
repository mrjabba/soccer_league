class PlayerstatsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :destroy]

  def new
    #TODO write a test for new here
    @title = "New Playerstat"
    @game = Game.find(params[:game_id])
    @team = Team.find(params[:team_id])
    @playerstat = Playerstat.new()
    @playerstat.game = @game
    @playerstat.team = @team
  end

  def create
    #TODO write a test for new here
    @game = Game.find(params[:playerstat][:game_id])
    @team = Team.find(params[:playerstat][:team_id])
    @playerstat = Playerstat.new(params[:playerstat])
    if @playerstat.save
      flash[:success] = "Player added to game successfully!"
      redirect_to @game
    else 
      @title = "New Playerstat"
      @playerstat = Playerstat.new()
      @playerstat.game = @game
      @playerstat.team = @team
      render 'new'
    end
  end 

  def destroy
    #TODO write a test for destroy here
    #TODO remove a player from a match. only allow 
    #when completed = false for the match?
    @playerstat = Playerstat.find(params[:id])
    @playerstat.destroy
    redirect_to @playerstat.game
  end
    
  private

    def authenticate
      deny_access unless signed_in?
    end

end
