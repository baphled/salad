require 'spec_helper'

describe '/parking/index.html' do
  context "No tickets have been found" do
    before(:each) do
      Resource.stub!(:all).and_return [mock_model(Resource, :name => "baphled", :project_id => '50164').as_null_object]
      render
    end
    
    it "should display a form" do
      response.should have_selector :form
    end
    it "should have an input box for the tag name" do
      response.should have_selector :input
    end

    it "should allow the user to submit the query" do
      response.should have_selector :button
    end
    
    it "should display a link to edit resources" do
      response.should have_selector :a, attribute = {:href => new_parking_path}
    end
    
    it "should have a drop down of all resources available" do
      response.should have_selector :select, attribute = {:id => "resource_id", :name => "resource[id]"} do |select|
        select.should contain 'baphled'
      end
    end
    
  end
end