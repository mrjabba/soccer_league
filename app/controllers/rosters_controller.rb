class RostersController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :destroy]

  #FIXME kmh we need to not show roster stats unless league does NOT support games???

  def new
    @title = "New Roster Item"
    @teamstat = Teamstat.find(params[:teamstat_id])
    @roster = Roster.new(:teamstat_id => @teamstat.id)
  end

  def show
    #TODO will be a choice between this (for game management)
    # and a new Career model
    if params[:career]
      @rosters = Roster.find_all_by_person_id(params[:id])
      render "career", :layout => false
    else
      @rosters = Roster.find(params[:id])
      @title = "View Roster"
    end
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