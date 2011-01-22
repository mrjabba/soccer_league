class TeamstatsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

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
    @league = League.find(params[:league_id])
    @teamstat = @league.teamstats.build(params[:teamstat])
    if @teamstat.save
      flash[:success] = "Team added to league successfully!"
      redirect_to @league
    else 
      @title = "New Teamstat"
      render 'new'
    end
  end 


  def destroy
    @teamstat = Teamstat.find(params[:id])
    @teamstat.destroy
    redirect_to @teamstat.league
  end
    
end
