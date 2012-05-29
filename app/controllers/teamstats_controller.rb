class TeamstatsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def new
    @title = "New Teamstat"
    @league = League.find(params[:league_id])
    @teamstat = Teamstat.new(:league_id => params[:league_id])
  end

  def show
    @teamstat = Teamstat.find(params[:id])     
    @league = @teamstat.league
    @title = "View Roster | #{@league.name} | #{@league.year} | #{@teamstat.team_name}"
  end
  
  def edit
    @teamstat = Teamstat.find(params[:id])
    @league = @teamstat.league
    @title = "Edit Teamstat"
  end
  
  def update
    @teamstat = Teamstat.find(params[:id])
    @teamstat.updated_by_id = current_user.id
    if @teamstat.update_attributes!(post_params_update)
      flash[:success] = "Teamstat updated."
      redirect_to @teamstat
    else
      @title = "Edit Teamstat"
      render 'edit'
    end    
  end

  def create
    @league = League.find(params[:league_id])
    @teamstat = @league.teamstats.build(post_params_create)
    @teamstat.created_by_id = current_user.id
    @teamstat.updated_by_id = current_user.id
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

  private

    def post_params_update
      params[:teamstat].slice(:player_tokens)
    end

  def post_params_create
    params[:teamstat].slice(:team_id, :player_tokens)
  end
end
