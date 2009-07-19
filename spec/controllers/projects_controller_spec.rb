require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProjectsController do
  
  describe "POST, create" do
    it "should save the project" do
      @project = mock_model(Project)
      Project.stub!(:new).and_return @project
      @project.should_receive :save
      post :create
    end
  end
end