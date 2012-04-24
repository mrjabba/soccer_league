class OrganizationsController < ApplicationController
  load_and_authorize_resource 
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @title = "Organization Management"
    @organizations = Organization.paginate(:page => params[:page])
  end

  def show
    @title = "View Organization"
    @organization = Organization.find(params[:id])
    @leagues = League.find_all_by_organization_id(params[:id])
    # @leagues = League.includes([:team]).find_all_by_organization_id(params[:id])
  end

  def new
    @title = "New Organization"
    @organization = Organization.new(:team_id => 1)
  end
  
  def edit
    @organization = Organization.find(params[:id])    
    @title = "Edit Organization"
  end

  def update
    @organization = Organization.find(params[:id])
    @organization.updated_by_id = current_user.id
    if @organization.update_attributes(params[:organization])
      flash[:success] = "Organization updated."
      redirect_to @organization
    else
      @title = "Edit Organization"
      render 'edit'
    end    
  end

  def create
    @organization = Organization.new(params[:organization])
    @organization.created_by_id = current_user.id
    @organization.updated_by_id = current_user.id
    if @organization.save
      flash[:success] = "Organization created successfully!"
      redirect_to @organization
    else 
      @title = "New Organization"
      render 'new'
    end
  end
end