class LeagueDecorator < Draper::Decorator
  delegate_all

  def games_exist
    @games_exist ||= model.games_exist?
  end

  def organization_id
    @organization_id ||= model.organization.id
  end

  def organization_name
    @organization_name ||= model.organization.name
  end

  def teamstats
    @teamstats ||= Teamstat.fetch_league_table(model.id)
  end

  def title
    "View League | " + model.name
  end

  def venues
    @venues ||= Venue.fetch_venues_for_league(model.id)
  end

  def zones
    @zones ||= model.leaguezones
  end
end
