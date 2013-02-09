class TeamLeagueHistoryController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def show
    @team = Team.find(params[:id])
    @teamstats = @team.teamstats
    render "team_league_history/show", :layout => false
  end
end
