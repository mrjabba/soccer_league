class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :destroy, :index, :show]
  helper_method :sort_column, :sort_direction
  
  def index
    @title = "All Users"
    @users = User.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
  end
  
  def show
    @user = User.find(params[:id])
    @title = "User Profile | #{@user.username}"
  end

  private
  
    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "username"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
      
end
