class TeamsController < ApplicationController
#FIXME add create and new? to authenticate
  before_filter :authenticate, :only => [:edit, :update]

  def index
    @title = "All teams"
    @teams = Team.paginate(:page => params[:page])
  end

  def show
    @team = Team.find(params[:id]) 
  end

  def edit
    #needs test
    @team = Team.find(params[:id])
    @title = "Edit team"
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      flash[:success] = "Team updated."
      redirect_to @team
    else
      @title = "Edit team"
      render 'edit'
    end    
  end

  def new
    #needs test
    @title = "New Team"
    @team = Team.new
  end

  def create
    #needs test
    @team = Team.new(params[:team])
    if @team.save
      flash[:success] = "Team created successfully!"
      redirect_to @team
    else 
      @title = "New Team"
      render 'new'
    end
  end 

  private

    def authenticate
      deny_access unless signed_in?
    end


end
