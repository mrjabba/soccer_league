class GamesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @title = "All games"
    @league = League.find(params[:league_id])
    @games = @league.games.paginate(:page => params[:page])
  end

  def new
    @title = "New Game"
    @league = League.find(params[:league_id])
    @game = Game.new(:league_id => @league.id)
  end

  def create
    @league = League.find(params[:league_id])

    @game = @league.games.build(params[:game].merge(:created_by_id => current_user.id,
                                                     :updated_by_id => current_user.id))

    if @game.save
      flash[:success] = "Game added successfully!"
      redirect_to @game
    else 
      @title = "New Game"
      render 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
    @title = "Edit game"
  end

  def update
    #TODO add test for update
    @game = Game.find(params[:id])
    @game.updated_by_id = current_user.id
    
    #TODO a better way? a checkbox workaround. manually set it. otherwise it doesnt seem to update
    #TODO maybe try this? params[:game][:completed] ||= [] per habtm railscast
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
    @game = GameDecorator.new(Game.find(params[:id]))
    @title = @game.title
  end

  def destroy
    #TODO should this be allowed? does it remove/reset necessary data?
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to league_games_path(@game.league)
  end
end