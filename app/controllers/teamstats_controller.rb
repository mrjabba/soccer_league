class TeamstatsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  
  def create
    #@teamstat = current_user.teamstats.build(params[:micropost])
    #@league = League.find_all_by_id(params[:teamstat.league_id])
    
    
    #logger.debug "zzzzzzzzzzzzzzzzzzzz The submitted object is " + params[:teamstat]
    #return render :text => "zzzzzzzzzzzzzzzzzzzz The submitted object is " + params[:teamstat].to_s
    #return render :text => "zzzzzzzzzzzzzzzzzzzz The submitted object is " + params.to_s

    # parent child work START
    #here is the prob. teamstat.league_id cant work b/c that field is not accessible!!
    #you need to pass the league_id somehow and still add it from the parent
    #there has to be a way to pass a fully functional objection

    #it might be possible to use session state somehow..though, i dont like that
    #maybe load the parent, then add a child then pass that the view?
    
    #thought about but didnt try using an initialize method for Teamstat so 
    #maybe you could just pass the id to the contrsuctor to set it that way? 
    #thought still doesnt feel right
    
    #maybe just setting the praent id to session state (or flash scope?)) 
    #then using it on the other side to pull back the object, expensive?
    
    #wait..maybe att_accessible for a teamstat shold include a league?
    #if you did that, maybe setting the hidden var in the form will 
    #make it accessible enough to handle this?
    
    # parent child work END

    

    #@teamstat = params[:teamstat]
    #return render :text => "zzzzzzzzzzzzzzzzzzzz The submitted object is " + @teamstat.class.to_s
    #@league = League.find(params[:id])

    @teamstat = @league.teamstats.build(:teamstat)
    #@teamstat = Teamstat.create!(params[:teamstat])
    if @teamstat.save
      flash[:success] = "Team stat created!"
      #redirect_to root_path
    #TODO render leagues/n where n it the league id?
      redirect_to leagues_path
    else
      @title = "New League"
      render 'new'
    end
    
  end

  def update
    @teamstat = Teamstat.find(params[:id])
    if @teamstat.update_attributes(params[:teamstat])
      flash[:success] = "teamstat updated."
      redirect_to @teamstat
    else
      @title = "Edit teamstat"
      render 'edit'
    end    
  end

  def new
    #return render :text => "The object is " + params[:league_id]
    #return render :text => "The object is #{@object}"
    #logger.debug "zzzzzzzzzzzzzzzzzzzz The object is " + params
    @title = "New teamstat"
    @teamstat = Teamstat.new(:league_id => params[:league_id])
    #@league_id = params[:league_id]
    #@teamstat = Teamstat.new
    #Teamstat.initialize()

  end

  def show
    @teamstat = Teamstat.find(params[:id])
  end

  def edit
    @teamstat = Teamstat.find(params[:id])
    @title = "Edit teamstat"
  end



  def destroy
    @teamstat.destroy
    #TODO render leagues/n where n it the league id?
    redirect_back_or league_path
  end
  
  private

    def authenticate
      deny_access unless signed_in?
    end
  
  
end
