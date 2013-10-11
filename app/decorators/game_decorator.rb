class GameDecorator < Draper::Decorator
  delegate_all

  def roster_count
    @roster_count ||= model.playerstats.count
  end
  
  def title
    "View Game | #{model.visiting_team_name} at #{model.home_team_name}" 
  end
end