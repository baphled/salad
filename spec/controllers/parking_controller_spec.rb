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
  
  describe "POST, create" do
    before(:each) do
      @resource = mock_model(Resource, :name => "Some new parked feature").as_null_object
      Resource.stub!(:new).and_return @resource
    end
    
    context "input is valid" do
      it "should create a new resource" do
        Resource.should_receive(:new)
        post :create  
      end
      
      it "should save the new resource" do
        @resource.should_receive(:save)
        post :create, {:resource => @resource}
      end
      
      it "should redirect to the parking index view" do
        @resource.stub!(:save).and_return true
        post :create, {:resource => @resource}
        response.should redirect_to parking_index_path
      end
    end
  end
end