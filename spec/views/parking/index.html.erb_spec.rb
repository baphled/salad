require 'spec_helper'

describe '/parking/index.html' do
  context "No tickets have been found" do
    before(:each) do
      render 'parking/index'
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
  end
  
  context "tickets have been retrieved" do
    it "should allow the user to retrieve a list of tickets from lighthouse"
    it "should have a import button"    
  end
end