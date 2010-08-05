require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ParkingController do
  describe "GET, tickets" do
    context "requesting a list of tickets" do
      it "can get tickets using Lighthouse API" do
        @resource = mock_model(Resource, :name => "baphled", :project => '50164').as_null_object
        Resource.stub!(:find).and_return @resource
        @resource.should_receive(:tickets).with("feature")
        get :tickets, {:parking => {:tag => 'feature'}, :resource => {:id => 1}}
      end
    end
  end
  
  describe "GET, new" do
    it "creates a new resource object" do
      Resource.should_receive(:new)
      get :new
    end
  end
  
  describe "POST, create" do
    before(:each) do
      @resource = mock_model(Resource, :name => "Some new parked feature").as_null_object
      Resource.stub!(:new).and_return @resource
    end
    
    context "resource is valid" do
      it "should create a new resource" do
        Resource.should_receive(:new)
        post :create  
      end
      
      it "is saved" do
        @resource.should_receive(:save)
        post :create, {:resource => @resource}
      end
      
      it "redirects to the parking page" do
        @resource.stub!(:save).and_return true
        post :create, {:resource => @resource}
        response.should redirect_to parking_index_path
      end
    end
  end

  describe "POST, import" do
    before(:each) do
      Resource.stub!(:find).and_return mock_model(Resource, :id => 1).as_null_object
    end

    context "successfully imports" do
      it "creates a parked items from tickets" do
        LightHouse.should_receive(:create)
        post :import, {:lighthouse =>{:ticket_id => ["9"]}, :resource => {:id => 1}}
      end
      
      it "displays a flash message" do
        post :import, {:lighthouse =>{:ticket_id => ["9"]}, :resource => {:id => 1}}
        flash[:notice].should_not be_empty
      end
      
      it "redirects to the parking page" do
        post :import, {:lighthouse =>{:ticket_id => ["9"]}, :resource => {:id => 1}}
        response.should redirect_to parking_index_path
      end
      
      it "saves the ticket's content body" do
        post :import, {:lighthouse =>{:ticket_id => ["9"]}, :resource => {:id => 1}}
        Resource.first.body.should_not be_nil
      end
      
      it "saves the ticket's title" do
        post :import, {:lighthouse =>{:ticket_id => ["9"]}, :resource => {:id => 1}}
        Resource.first.title.should_not be_nil        
      end
    end
    
    context "failing imports" do
      context "with one resource" do
        before(:each) do
          LightHouse.stub!(:create).and_return false
          post :import, {:lighthouse =>{:ticket_id => ["9", "41"]}, :resource => {:id => 1}}
        end

        it "displays a flash message" do
          flash[:error].should contain "Unable to save tickets"
        end

        it "displays the tickets page" do
          response.should redirect_to parking_index_path
        end
      end
    end
  end

  describe "GET, unique-resource-name"  do
    context "not unique" do
      before(:each) do
        Resource.make
      end
      
      it "returns an error message" do
        get :unique_resource_name, {:name => 'baphled'}
        response.should contain 'Must be a unique resource name.'
      end
    end
  end
end