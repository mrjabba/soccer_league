require 'spec_helper'

describe TeamLeagueHistoryController do
 render_views

  describe "GET 'show'" do
    describe 'failure' do
      it "should render a 404" do
        lambda do
          get :show, :id => 123
        end.should raise_error(ActionController::RoutingError)
      end
    end

    describe 'success' do
      let(:teamstat) { FactoryGirl.create(:teamstat) }
      it "should be successful" do
        get :show, :id => teamstat.team_id
        response.should render_template('team_league_history/show')
        response.should be_success
      end
    end
  end

end