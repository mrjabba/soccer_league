class TechnicalstaffsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :destroy]

  def new
    @title = "New Technical Staff"
    @teamstat = Teamstat.find(params[:teamstat_id])
    @technicalstaff = Technicalstaff.new(:teamstat_id => @teamstat.id)
  end

  def create
    @teamstat = Teamstat.find(params[:teamstat_id])
    @technicalstaff = @teamstat.technicalstaffs.build(params[:technicalstaff])
    @technicalstaff.created_by_id = current_user.id
    @technicalstaff.updated_by_id = current_user.id
    if @technicalstaff.save
      flash[:success] = "Staff created successfully!"
      redirect_to @teamstat
    else
      @title = "New Technical Staff"
      render 'new'
    end
  end

  def destroy
    @technical_staff = Technicalstaff.find(params[:id])
    @technical_staff.destroy
    redirect_to @technical_staff.teamstat
  end
end