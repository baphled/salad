require 'spec_helper'

describe "/parking/new.html" do

  context "creating a new resource" do
    before(:each) do
      assigns[:resource] = Resource.new
      render
    end
    
    it "displays the page title" do
      response.should contain "New Resource"
    end
    it "has a form" do
      response.should have_selector :form
    end
    
    it "has a project name" do
      response.should have_selector :input, attribute = {:id => "resource_name"}
    end
    it "has a project id" do
      response.should have_selector :input, attribute = {:id => "resource_project"}
    end
    
    it "has a save button" do
      response.should have_selector :button
    end
  end
end