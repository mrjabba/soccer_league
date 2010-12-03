class TeamstatsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :destroy]

  def new
    @title = "New Teamstat"
    @league = League.find(params[:league_id])
    @teamstat = Teamstat.new()
    @teamstat.league = @league
  end

  def show
    @teamstat = Teamstat.find(params[:id]) 
    @roster = Roster.find_all_by_teamstat_id(params[:id])
    @league = @teamstat.league
    @title = "View Roster | #{@league.name} | #{@league.year} | #{@teamstat.team.name}"
  end

  def create
    @league = League.find(params[:teamstat][:league_id])
    @teamstat = Teamstat.new(params[:teamstat])
    if @teamstat.save
      flash[:success] = "Team added to league successfully!"
      redirect_to @league
    else 
      @title = "New Teamstat"
      @teamstat = Teamstat.new()
      @teamstat.league = @league
      render 'new'
    end
  end 

  def destroy
    #TODO remove a team from a league. only allow 
    #when matches = 0 for the league/year?
    @teamstat = Teamstat.find(params[:id])
    @teamstat.destroy
    redirect_to @teamstat.league
  end
    
  private

    def authenticate
      deny_access unless signed_in?
    end

end
