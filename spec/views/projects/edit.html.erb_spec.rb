require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/edit.html.erb" do
  before(:each) do
    @project = mock_model(Project,
                          :null_object=>true,
                          :title=>"Some different")
    assigns[:project] = @project
  end
  
  describe "GET, edit" do
    before(:each) do
      render
    end
    
   it "should have a form" do
      response.should have_tag("form[action=#{project_path(@project)}][method=post]") do
        with_tag('input#project_title[name=?]', "project[title]")
        with_tag('textarea#project_description[name=?]', "project[description]")
        with_tag('textarea#project_aim[name=?]', "project[aim]")
      end
    end
    
  end
  
  describe "POST update" do
    
    context "unable to update" do
      before(:each) do
        @project.stub!(:update_attributes).and_return false
        render
      end

      it "should not update the project if there is a problem" do
        response.should have_tag("form[action=#{project_path(@project)}][method=post]")
      end
    
    end
  end
end