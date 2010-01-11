require File.dirname(__FILE__) + '/../../spec_helper'

describe "/steps/_step_search.html.erb" do
  before(:each) do
    @given_steps = []
    3.times { |step_number| @given_steps << mock_model(Step,:title => "Given #{step_number +1}")  }
    assigns[:search] = @given_steps
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
      response.should contain "Results (#{assigns[:search].size.to_s})"
    end
  end
end