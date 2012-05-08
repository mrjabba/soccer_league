class ApplicationController < ActionController::Base
  protect_from_forgery
#  include SessionsHelper
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access Denied"
    redirect_to root_url
  end

  def per_page
    default_size = 10
    max_size = 50
    params[:per_page].to_i < max_size ? params[:per_page] || default_size : default_size
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
