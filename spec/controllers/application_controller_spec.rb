require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationController do

  context "Projects" do
    controller_name :projects
    
    describe "GET, new"  do
      it "should render the no sidebar layout" do
        get :new
        response.should use_layout("no_sidebar")
      end
    end

    describe "POST, create" do
      before(:each) do
        @project = mock_model(Project).as_new_record.as_null_object
        @project.stub!(:save).and_return false
        Project.stub!(:new).and_return @project
      end

      it "should render the no sidebar layout" do
        post :create
        response.should use_layout("no_sidebar")
      end
    end
  
    describe "GET, edit" do
      it "should render the no sidebar layout" do
        get :edit, {:id => 1}
        response.should use_layout("no_sidebar")
      end
    end
    
    describe "GET, import" do
      it "should render the no sidebar layout" do
        get :import, {:id => 1}
        response.should use_layout("no_sidebar")
      end
    end
  end
  
  context "Features" do
    controller_name :features
    
    describe "GET, export" do
      it "should render the no sidebar layout" do
        get :export, {:id => 1}
        response.should use_layout("no_sidebar")
      end
    end
    
    describe "GET, changes" do
      it "should render the no sidebar layout" do
        get :changes, {:id => 1}
        response.should use_layout("no_sidebar")
      end      
    end

    describe "GET, merge" do
      it "should render the no sidebar layout" do
        get :merge, {:id => 1}
        response.should use_layout("no_sidebar")
      end      
    end
    
    describe "GET, system_merge" do
      it "should render the no sidebar layout" do
        get :system_merge, {:id => 1}
        response.should use_layout("no_sidebar")
      end      
    end
    
    describe "GET, file" do
      it "should render the no sidebar layout" do
        get :file, {:id => 1}
        response.should use_layout("no_sidebar")
      end
    end
  end
  
  context "Parking" do
    controller_name :parking
    
    describe "GET, tickets" do
      before(:each) do
        @resource = mock_model(Resource, {:id => 1, :name => 'baphled', :project => '50164'}).as_null_object
        Resource.stub!(:find).and_return @resource
      end
      it "should render the no sidebar layout" do
        get :tickets, {:resource => {:id => '1'}, :parking => {:tag => 'feature'}}
        response.should use_layout("no_sidebar")
      end
    end
  end
end