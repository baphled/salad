require 'spec_helper'

describe '/parking/index.html' do
  context "No tickets have been found" do
    before(:each) do
      assigns[:resources] = [mock_model(Resource, :name => "baphled", :project_id => '50164').as_null_object]
      assigns[:tickets] = [mock_model(Resource, :name => "baphled", :project_id => '50164').as_null_object]
      render
    end
    
    it "displays a form" do
      response.should have_selector :form
    end
    it "has an input box for the tag name" do
      response.should have_selector :input
    end

    it "allows the user to submit the query" do
      response.should have_selector :button
    end
    
    it "displays a link to edit resources" do
      response.should have_selector :a, attribute = {:href => new_parking_path}
    end
    
    it "should has a drop down of all resources available" do
      response.should have_selector :select, attribute = {:id => "resource_id", :name => "resource[id]"} do |select|
        select.should contain 'baphled'
      end
    end
    
  end


  context "parked items present" do
    before(:each) do
      assigns[:resources] = [mock_model(Resource, :name => "baphled", :project_id => '50164').as_null_object]
      assigns[:tickets] = [mock_model(Resource, :name => "baphled", :project_id => '50164').as_null_object]
      render
    end

    it "has an unordered list" do
      response.should have_selector :ul, attribute = {:id => "resource_list"}
    end

    it "displays each parked item" do
      response.should have_selector :ul, attribute = {:id => "resource_list"}
        response.should have_selector :li
      end
    end
end