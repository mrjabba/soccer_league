class RostersController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :destroy]

  def new
    @title = "New Roster Player"
    @teamstat = Teamstat.find(params[:teamstat_id])
    @roster = Roster.new()
    @roster.teamstat = @teamstat
  end

  def create
    @teamstat = Teamstat.find(params[:roster][:teamstat_id])
    @roster = Roster.new(params[:roster])
    if @roster.save
      flash[:success] = "Player added to team successfully!"
      redirect_to @teamstat
    else 
      @title = "New Roster Player"
      @roster = Roster.new()
      @roster.teamstat = @teamstat
      render 'new'
    end
  end

  def destroy
    @roster = Roster.find(params[:id])
    @roster.destroy
    redirect_to @roster.teamstat
  end
    
  private

    def authenticate
      deny_access unless signed_in?
    end

end
