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
        instructions.should contain 'Add a project'
      end
    end

  end

  context "when there are projects" do

    before(:each) do
      @project = stub(Project,
                      :title => 'a project',
                      :description => 'a description',
                      :aim => 'An aim')
      assigns[:project] = @project
      render 'welcome/index'
    end

    it "should display the last project" do
      response.should have_selector :div, attribute = {:id=>"latest_project"} do |project_info|
        project_info.should have_selector :span, :content => @project.title
        project_info.should have_selector :span, :content => @project.description
        project_info.should have_selector :span, :content => @project.aim
      end
    end
  end

end
