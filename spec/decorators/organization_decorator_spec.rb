require 'spec_helper'

describe OrganizationDecorator do
  let(:organization) {Organization.new}
  subject do
    organization.leagues.build(:name => 'foo')
    OrganizationDecorator.new(organization)
  end

  describe 'leagues' do
    it 'shows the leagues' do
      subject.leagues.size.should == 1
    end
  end

  describe 'title' do
    let(:title) { "title"}
    before { subject.name = title}
    it 'shows the title' do
      subject.title.should == "View Organization | #{title}"
    end
  end
end
