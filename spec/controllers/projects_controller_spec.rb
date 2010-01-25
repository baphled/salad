require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProjectsController do
  before(:each) do
    @project = mock_model(Project).as_new_record.as_null_object
  end
  describe "POST, create" do
    before(:each) do
      Project.stub!(:new).and_return @project
    end

    context "a valid project" do
      it "should save the project" do
        @project.should_receive(:save).and_return true
        post :create
      end
    
      it "should display a flash message" do
        post :create
        flash.should contain "Project: #{@project.title} was created"
      end
    end

    context "an invalid project" do
      before(:each) do
        @project.stub(:save).and_return false
      end

      it "should not save the project" do
        @project.should_receive(:save).and_return false
        post :create
      end

      it "should render the new form" do
        post :create
        response.should render_template :new
      end
    end
  end

end