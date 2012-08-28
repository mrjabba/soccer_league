require 'spec_helper'

describe RostersController do
  render_views

  describe "GET 'new'" do
    it "should be successful"

    it "should have the right title"
  end

  describe "POST 'create'" do
    describe "failure" do
      it "should validate input"
    end

    describe "success" do
      it "should create a roster item"
      it "should redirect to the teamstat show page"
      it "should have a flash message"
    end
  end

  describe "DELETE 'destroy'" do
    describe "success" do
      it "should destroy the roster"
      it "should redirect to the teamstat show page"
    end
  end
end