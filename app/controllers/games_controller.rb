class GamesController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update]

  def index
    @title = "All games"
    @league = League.find(params[:league_id])
    @games = Game.where("league_id = ?", params[:league_id]).paginate(:page => params[:page])
  end

  def new
    @title = "New Game"
    @league = League.find(params[:league_id])
    @game = Game.new()
    @game.league = @league
  end

  def create
    #TODO some validation that needs to occur, probably in the model
    # ensure that visting team and home team are not the same id
    # tweak teams query in view to only how teams for THAT league.
    @game = Game.new(params[:game])
    if @game.save
      flash[:success] = "Game added successfully!"
      
      #TODO we r losing the ID for @game here as well
      # workaround didnt work
      # try commenting out the activerecord callback to see if it 
      # still works
      #@game = Game.find(params[:game])
      redirect_to @game
    else 
      @title = "New Game"
      @game = Game.new()
      @game.league = params[:game][:league_id]
      render 'new'
    end
  end 

 def edit
    #needs test
    @game = Game.find(params[:id])
    @title = "Edit game"
  end

  def update
    #TODO add test for update
    @game = Game.find(params[:id])
    
    #TODO a better way? a checkbox workaround. manually set it. otherwise it doesnt seem to update
    @game.completed = params[:game][:completed]
    
    if @game.update_attributes(params[:game])
      flash[:success] = "Game updated."
      #TODO figure out why it loses the ID here and I had to query thd db again
      #Didnt have to do this for other controllers? Is it the ActveRecord callback?
      @game = Game.find(params[:id])
      redirect_to @game
    else
      @title = "Edit game"
      render 'edit'
    end    

  end

  def show
    @game = Game.find(params[:id]) 
    @title = "View Game | #{@game.visiting_team.name} at #{@game.home_team.name}" 
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

end
