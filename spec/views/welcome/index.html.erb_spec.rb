require 'spec_helper'

describe "/welcome/index" do
  

  context "when there are no projects" do

    before(:each) do
      assigns[:project] = nil
      render 'welcome/index'
    end

    it "should display a message stating that there are no projects in Salad" do
      response.should have_tag('p', %r[There are no projects])
    end

    it "should display a link to the projects page" do
      response.should have_selector :div do |instructions|
        instructions.should contain 'add a project'
      end
    end

  end

  context "when there are projects" do

    before(:each) do
      @project = stub_model(Project,
                      :title => 'A project',
                      :creation_date => Time.now.to_s(:long),
                      :features => [],
                      :null_object => true).as_new_record
      assigns[:project] = @project
      
    end

    context "with a feature" do
      before(:each) do
        assigns[:project].stub(:features).and_return [mock_model(Feature).as_new_record]
        render 'welcome/index'
      end

      it "should display the last project" do
        response.should have_selector :div, attribute = {:id=>"latest_project"} do |project_info|
          project_info.should have_selector :span, :content => @project.title
        end
      end

      it "should display the number of features the latest project has" do
        response.should have_selector :div, attribute = {:id=>"latest_project"} do |project_info|
          project_info.should contain "#{@project.features.count} features"
        end
      end
    end
    

    context "when the latest project has no features" do
      before(:each) do
        assigns[:project].stub(:features).and_return []
        render 'welcome/index'
      end
      it "should display a message stating that the project has no features" do
        response.should have_selector :div, attribute = {:id=>"latest_project"} do |project_info|
          project_info.should contain "which has no features"
        end
      end
    end
    
  end

end
