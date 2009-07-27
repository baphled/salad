require File.dirname(__FILE__) + '/../../spec_helper'

describe "/projects/features.html.erb" do
  before(:each) do
    @project = Project.find(1)
    @features = @project.features
    assigns[:project] = @project
    render
  end
  it "should display a list of features" do
    response.should have_selector :ul do |list|
      @features.each do |feature|
        list.should have_selector :li, :content => feature.title
      end
    end
  end
end