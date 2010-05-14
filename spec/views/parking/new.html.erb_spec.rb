require 'spec_helper'

describe "/parking/new.html" do

  context "creating a new resource" do
    before(:each) do
      assigns[:resource] = mock_model(Resource).as_new_record.as_null_object
      render
    end
    
    it "should display the page title" do
      response.should contain "New Resource"
    end
    it "should have a form" do
      response.should have_selector :form
    end
    
    it "should have a project name" do
      response.should have_selector :input, attribute = {:id => "resource_name"}
    end
    it "should have a project id" do
      response.should have_selector :input, attribute = {:id => "resource_project_id"}
    end
  end
end