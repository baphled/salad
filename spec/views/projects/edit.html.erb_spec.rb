require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/edit.html.erb" do
  before(:each) do
    @project = stub_model(Project).as_null_object
    assigns[:project] = @project
  end
  
  describe "POST update" do
    
    context "unable to update" do
      before(:each) do
				@project.errors.stub!(:[]).and_return(:title)
        @project.stub!(:update_attributes).and_return false
        render
      end

      it "should not update the project if there is a problem" do
        response.should have_tag("form[action=#{project_path(@project)}][method=post]")
      end
    
    end
  end
end