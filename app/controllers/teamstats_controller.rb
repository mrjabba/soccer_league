class TeamstatsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def index
    #yuk, extract to TeamFinder
    if params[:league_id] && params[:q]
      respond_to do |format|
        format.json { render :json => Teamstat.fetch_teams_by_name_for_league_as_array(params[:league_id], params[:q])}
      end
    end
  end

  def new
    @title = "New Teamstat"
    @league = League.find(params[:league_id])
    @teamstat = Teamstat.new(:league_id => params[:league_id])
  end

  def show
    @teamstat = TeamstatDecorator.new(Teamstat.find(params[:id]))
    @title = @teamstat.title
  end
  
  def edit
    @teamstat = Teamstat.find(params[:id])
    @league = @teamstat.league
    @title = "Edit Teamstat"
  end
  
  def update
    @teamstat = Teamstat.find(params[:id])
    @teamstat.updated_by_id = current_user.id
    if @teamstat.update_attributes!(params[:teamstat])
      flash[:success] = "Teamstat updated."
      redirect_to @teamstat
    else
      @title = "Edit Teamstat"
      render 'edit'
    end    
  end

  def create
    @league = League.find(params[:league_id])
    @teamstat = @league.teamstats.build(params[:teamstat].merge(:created_by_id => current_user.id,
                                                                :updated_by_id => current_user.id))
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
