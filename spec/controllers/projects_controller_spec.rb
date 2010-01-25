require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProjectsController do
  
  describe "POST, create" do
    before(:each) do
      @project = mock_model(Project).as_new_record.as_null_object
    end
    context "project successfully created" do
      before(:each) do
        Project.stub!(:new).and_return @project
      end
      
      it "should save the project" do
        @project.should_receive(:save).and_return true
        post :create, :project => @project
      end
    
      it "should display a flash message" do
        post :create, :project => @project
        flash.should contain "Project: #{@project.title} was created"
      end
    end
  end

  context "project unsuccessfully created" do
    it "should not save the project"
    it "should render the new form"
  end
  
end