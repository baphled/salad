require File.dirname(__FILE__) + '/../../spec_helper'

describe "/projects/features.html.erb" do
  before(:each) do
    @project = stub_model(Project).as_null_object
    assigns[:project] = @project
  end

  describe "GET, projects" do
    context "project has no features"  do
      before(:each) do
        render
      end
      
      it "should not display a list of features" do
        response.should_not have_selector :div, attribute = {:id => "features"} do |content|
          content.should_not have_selector :ul do |list|
            list.should_not have_selector :li
          end
        end
      end
    end
    
    context "project has features"  do
      before(:each) do
        @project_features = [stub_model(Feature,:title=>'first feature').as_null_object]
        render :partial => '/common/list/features', :locals => {:features => @project_features, :order =>true}
      end

      it "should display a list of features" do
        response.should have_selector :ul, attribute = {:id => 'features'} do |list|
          @project.features.each do |feature|
            list.should have_selector :li, :content => feature.title
          end
        end
      end

      it "should display projects summary" do
        response.should have_selector :span, attribute = {:class=>"list_content"} do |project_info|
          project_info.should contain "Title: #{@project.title}"
          project_info.should contain "Created at: #{@project.description}"
        end
      end
    end
    
  end
end