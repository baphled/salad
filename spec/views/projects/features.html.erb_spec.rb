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
  
  it "should display projects summary" do
    response.should have_selector :fieldset, attribute = {:class=>"project_field"} do |project_field|
      project_field.should have_selector :div, attribute = {:class=>"project_info"} do |project_info|
        project_info.should have_selector :span, :content => @project.title
        project_info.should have_selector :span, :content => @project.description
        project_info.should have_selector :span, :content => @project.aim
      end
    end
  end
end