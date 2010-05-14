require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ParkingController do
  describe "GET, tickets" do
    context "requesting a list of tickets" do
      it "should do a search using the LightHouse API for tags" do
        Lighthouse::Ticket.should_receive(:find).with(:all, :params => { :project_id => '50164', :q => "state:open tagged:feature" })
        get :tickets, {:tag => 'feature'}
      end
    end
  end
  
  describe "GET, new" do
    it "should create a new resource model" do
      Resource.should_receive(:new)
      get :new
    end
  end
end