require 'spec_helper'

describe "/parking/tickets.html" do

  context "a successful search has been requested" do
    before(:each) do
      @resource = Resource.new(:name => 'baphled', :project => '50164')
      assigns[:tickets] = @resource.tickets('feature')
      assigns[:resource] = @resource
      render
    end
    
    it "should display a list of tickets" do
      response.should have_selector :ul
    end
    
    it "should display each ticket's title" do
      assigns[:tickets].should_not be_empty
    end
    
    it "should display each ticket's date" do
      assigns[:tickets].each do |ticket|
        ticket.created_at.should_not be_nil
      end
    end
    
    it "should display each ticket's tag" do
      response.should have_selector :ul do |list|
        list.should have_selector :li do |content|
          content.should contain assigns[:tickets].first.tags.first
        end
      end
    end
    
    it "should display each ticket's description" do
      assigns[:tickets].each do |ticket|
        ticket.original_body.should_not be_empty
      end
    end
    
    it "should have a checkbox for each result" do
      assigns[:tickets].each do |ticket|
        response.should have_selector :input, attribute = {:type => "checkbox"}
      end
    end
  end

  context "no tickets where found" do
    before(:each) do
      assigns[:tickets] = []
      assigns[:resource] = Resource.new(:name => 'baphled', :project => '50164')
    end

    it "should return an empty list" do
      response.should_not have_selector :ul, attribute = {:id => 'tickets'}
    end
  end
end