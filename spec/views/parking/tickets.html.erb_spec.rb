require 'spec_helper'

describe "/parking/tickets.html" do

  context "a successful search has been requested" do
    before(:each) do
      @resource = Resource.create(:name => 'baphled', :project_id => '50164')
    end
    
    it "should display a list of tickets" do
      assigns[:tickets] = @resource.tickets('feature')
      render
      response.should have_selector :ul
    end
    
    it "should display each ticket's title" do
      assigns[:tickets] = @resource.tickets('feature')
      render
      assigns[:tickets].should_not be_empty
    end
    
    it "should display each ticket's date"
    it "should display each ticket's tag"
    it "should display each ticket's description"
  end

  context "no tickets where found" do
    it "should return an empty list"
    it "should display a flash message"
  end
end