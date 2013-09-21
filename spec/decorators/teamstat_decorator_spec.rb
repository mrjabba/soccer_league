require 'spec_helper'

describe TeamstatDecorator do
  let(:teamstat)  { Teamstat.new }
  let(:league) { League.new(:name => "myLeague", :from_year => 1999, :to_year => 2010) }
  let(:team) { Team.new(:name => "myTeam") }
  
  subject do
    teamstat.team = team
    teamstat.league = league
    TeamstatDecorator.new(teamstat)
  end

  describe 'league' do
    it 'shows the league' do
      subject.league.should == league
    end
  end

  describe 'title' do
    it 'shows the title' do
      subject.title.should include(league.name)
      subject.title.should include(league.from_year.to_s)
      subject.title.should include(league.to_year.to_s)
      subject.title.should include(team.name)
    end
  end
end
