require 'spec_helper'

describe LeagueDecorator do
  let(:league) {League.new}
  subject do
    league.leaguezones.build(:name => 'foo')
    LeagueDecorator.new(league)
  end

  describe 'games_exist?' do
    before {league.stub(:games_exist?).and_return(true)}
    it 'shows the games_exist' do
      subject.games_exist.should be_true
    end
  end

  describe 'teamstats' do
    before {Teamstat.stub(:fetch_league_table).and_return([Teamstat.new])}
    it 'shows the teamstats' do
      subject.teamstats.size.should == 1
    end
  end

  describe 'title' do
    let(:title) { "title"}
    before { subject.name = title}
    it 'shows the title' do
      subject.title.should == "View League | #{title}"
    end
  end

  describe 'venues' do
    before {Venue.stub(:fetch_venues_for_league).and_return([Venue.new])}
    it 'shows the venues' do
      subject.venues.size.should == 1
    end
  end

  describe 'zones' do
    it 'shows the leaguezones' do
      subject.zones.size.should == 1
    end
  end
end
