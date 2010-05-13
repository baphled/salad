require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class ParkingController < ActionController::Base
end

describe ParkingController do
  describe "GET, index" do
    context "requesting a list of tickets" do
      it "should be able to retrieve all tickets with a given tag"      
    end
    
    context "a successful search has been requested" do
      it "should display a list of open tickets"
    end
    
    context "no tickets where found" do
      it "should return an empty list"
      it "should display a flash message"
    end
  end
end