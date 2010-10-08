class LeaguesController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]

  def index
    @title = "All Leagues"
    @leagues = League.paginate(:page => params[:page])
  end

  def show
    @league = League.find(params[:id])
    @teamstats = Teamstat.find_all_by_league_id(params[:id])
    #TODO you r gonna need a join here to get team name????
    #@teams = Team.find_all_by_id(@teamstats)
    
  end

  def new
    @title = "New League"
    @league = League.new(:team_id => 1)
    #@league.teamstats.build
  end
  
  def edit
    @league = League.find(params[:id])
    if(params[:new]) 
      @league.teamstats.build
    end
    
    @title = "Edit league"
  end

  def update
    @league = League.find(params[:id])
    if @league.update_attributes(params[:league])
      flash[:success] = "League updated."
      redirect_to @league
    else
      @title = "Edit league"
      render 'edit'
    end    
  end

  def create
    #return render :text => "The object is " + params.to_s
    logger.debug "zzzzzzzzzzzzzzzzzzzz The object is " + params.to_s
    @league = League.new(params[:league])
    if @league.save
      flash[:success] = "League created successfully!"
      redirect_to @league
      #redirect_to user_path(@user)
    else 
      @title = "New League"
      render 'new'
    end
  end  

  private

    def authenticate
      deny_access unless signed_in?
    end

end
