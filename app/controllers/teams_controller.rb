class TeamsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  helper_method :sort_column, :sort_direction

  def index
    @title = "Team Repository"
    @teams = Team.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
  end

  def show
    @team = Team.find(params[:id]) 
    #temporary code sin, get league.
    @league = @team.teamstat.league if @team.teamstat != nil 
    @title = "View Team | " + @team.name
  end

  def edit
    @team = Team.find(params[:id])
    @title = "Edit team"
  end

  def update
    @team = Team.find(params[:id])
    @team.updated_by_id = current_user.id
    if @team.update_attributes(params[:team])
      flash[:success] = "Team updated."
      redirect_to @team
    else
      @title = "Edit team"
      render 'edit'
    end    
  end

  def new
    @title = "New Team"
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])
    @team.created_by_id = current_user.id
    @team.updated_by_id = current_user.id
    if @team.save
      flash[:success] = "Team created successfully!"
      redirect_to @team
    else 
      @title = "New Team"
      render 'new'
    end
  end 

  private

    def sort_column
      Team.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
