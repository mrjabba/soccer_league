class RostersController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :destroy]

  def new
    @title = "New Roster Item"
    @teamstat = Teamstat.find(params[:teamstat_id])
    @roster = Roster.new(:teamstat_id => @teamstat.id)
  end

  def create
    @teamstat = Teamstat.find(params[:teamstat_id])
    @roster = @teamstat.rosters.build(params[:roster])
    @roster.created_by_id = current_user.id
    @roster.updated_by_id = current_user.id
    if @roster.save
      flash[:success] = "Roster item created successfully!"
      redirect_to @teamstat
    else
      @title = "New Roster Item"
      render 'new'
    end
  end

  def destroy
    @roster = Roster.find(params[:id])
    @roster.destroy
    redirect_to @roster.teamstat
  end
end