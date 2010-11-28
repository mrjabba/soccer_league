class LeaguesController < ApplicationController
  before_filter :authenticate, :only => [:create, :edit, :update]

  def index
    @title = "League Management"
    @leagues = League.paginate(:page => params[:page])
  end

  def show
    @title = "View League"
    @league = League.find(params[:id])
    @league_games_size = Game.where(:league_id => params[:id]).size
    @teamstats = Teamstat.find_all_by_league_id(params[:id])
  end

  def new
    @title = "New League"
    @league = League.new(:team_id => 1)
  end
  
  def edit
    @league = League.find(params[:id])    
    @title = "Edit league"
  end

  def update
    @league = League.find(params[:id])
    if @league.update_attributes(params[:league])
      flash[:success] = "League updated."
      redirect_to @league
    else
      @title = "Edit league"
      render 'edit'
    end    
  end

  def create
    @league = League.new(params[:league])
    if @league.save
      flash[:success] = "League created successfully!"
      redirect_to @league
    else 
      @title = "New League"
      render 'new'
    end
  end  

  private

    def authenticate
      deny_access unless signed_in?
    end

end
