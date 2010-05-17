require 'spec_helper'

describe "/parking/tickets.html" do

  context "a successful search has been requested" do
    before(:each) do
      @resource = Resource.create(:name => 'baphled', :project_id => '50164')
      assigns[:tickets] = @resource.tickets('feature')
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
      assigns[:tickets].each do |ticket|
        response.should have_selector :ul do |list|
          list.should have_selector :li do |content|
            content.should contain ticket.tags.first
          end
        end
      end
    end
    
    it "should display each ticket's description" do
      assigns[:tickets].each do |ticket|
        content.should contain ticket.original_body
      end
    end
  end

  context "no tickets where found" do
    it "should return an empty list"
    it "should display a flash message"
  end
end