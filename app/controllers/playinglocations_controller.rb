class PlayinglocationsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :destroy]

  def new
    @title = "New Playing Location"
    @teamstat = Teamstat.find(params[:teamstat_id])
    @playinglocation = Playinglocation.new(:teamstat_id => @teamstat.id)
  end

  def create
    @teamstat = Teamstat.find(params[:teamstat_id])
    @playinglocation = @teamstat.playinglocations.build(params[:playinglocation])
    @playinglocation.created_by_id = current_user.id
    @playinglocation.updated_by_id = current_user.id
    if @playinglocation.save
      flash[:success] = "Playing location created successfully!"
      redirect_to @teamstat
    else
      @title = "New Playing Location"
      render 'new'
    end
  end

  def destroy
    @playinglocation = Playinglocation.find(params[:id])
    @playinglocation.destroy
    redirect_to @playinglocation.teamstat
  end
end