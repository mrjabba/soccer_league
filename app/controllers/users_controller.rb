class UsersController < ApplicationController
  load_and_authorize_resource #requires controller to be RESTful?
  before_filter :authenticate_user!, :only => [:new, :create, :destroy, :index, :show]
  helper_method :sort_column, :sort_direction
  
  def index
    if(params[:role])
      @role = (params[:role] != "" && params[:role]) || "Disabled"
      @title = "#{@role.capitalize} Users"
      @users = User.with_role(params[:role]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
    else
      @title = "All Users"
      @users = User.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
    end
  end

  def show
    @user = User.find(params[:id])
    @title = "User Profile | #{@user.username}"
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end  

  private
  
    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "username"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
      
end
