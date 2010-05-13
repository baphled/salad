require 'spec_helper'

describe "/parking/tickets.html" do
  context "a successful search has been requested" do
    it "should display a list of tickets"
    it "should display each ticket's title"
    it "should display each ticket's date"
    it "should display each ticket's tag"
    it "should display each ticket's description"
  end

  context "no tickets where found" do
    it "should return an empty list"
    it "should display a flash message"
  end
end