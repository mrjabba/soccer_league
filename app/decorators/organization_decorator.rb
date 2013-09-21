class OrganizationDecorator < Draper::Decorator
  delegate_all

  def leagues
    @leagues ||= model.leagues
  end

  def title
    "View Organization | " + model.name
  end
end
