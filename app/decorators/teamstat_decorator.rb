class TeamstatDecorator < Draper::Decorator
  delegate_all

  def league
    @league ||= model.league
  end

  def title
    "View Roster | #{league.name} | #{league.from_year}-#{league.to_year} | #{model.team_name}"
  end
end