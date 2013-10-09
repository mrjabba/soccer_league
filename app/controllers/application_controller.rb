class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :allow_anonymous_view?
  before_filter :set_locale
  #  include SessionsHelper
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access Denied"
    redirect_to root_url
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  def per_page
    default_size = 10
    max_size = 50
    params[:per_page].to_i < max_size ? params[:per_page] || default_size : default_size
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def allow_anonymous_view?
    unless APP_CONFIG['allow_anonymous_view']
      authenticate_user!
    end
  end
end
