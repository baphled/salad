require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationController do

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
end