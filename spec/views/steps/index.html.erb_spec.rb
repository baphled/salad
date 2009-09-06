require File.dirname(__FILE__) + '/../../spec_helper'

describe "/steps/index.html.erb" do
  before(:each) do
    assigns[:steps] = Step.pagination_search "Given",1
    assigns[:search] = Step.search "Given"
    render
  end
  
  describe "GET, search" do
    it "should have a form" do
      response.should have_selector :form
    end
    
    it "should have a text field" do
      response.should have_selector :form do |form|
        form.should have_selector :input, attribute = {:type=>"text"}
      end
    end
    
    it "should allow us to search for steps" do
      response.should have_selector :form do |form|
        form.should have_selector :input, attribute = {:type=>"submit"}
      end
    end
    
    it "should display the number of results found" do
      response.should contain "Results (#{assigns[:steps].size.to_s})"
    end
  end
end