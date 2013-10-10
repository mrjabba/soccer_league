class CareersController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :destroy]

  def show
    #TODO will be a choice between this (for game management)
    # and a new Career model
    @rosters = Roster.find_all_by_person_id(params[:id])
    render "career", :layout => false
  end
end