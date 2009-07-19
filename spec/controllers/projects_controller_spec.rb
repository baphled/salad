require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProjectsController do
  
  describe "POST, create" do
      context "project successfully" do
      
      before(:each) do
        @project = mock_model(Project,:title=>"A project")
        Project.stub!(:new).and_return @project        
      end
      
      it "should save the project" do
        @project.should_receive :save
        post :create
      end
    
      it "should display a flash message" do
        @project.stub!(:save).and_return true
        post :create
        flash.should contain "A project was created"
      end
    end
  end
end