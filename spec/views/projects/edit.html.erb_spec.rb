require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/edit.html.erb" do
  
  describe "GET, edit" do
    before(:each) do
      @project = mock_model(Project,:null_object=>true)
      assigns[:project] = @project
      render
    end
    
   it "should have a form" do
      response.should have_tag("form[action=#{project_path(@project)}][method=post]") do
        with_tag('input#project_title[name=?]', "project[title]")
        with_tag('textarea#project_description[name=?]', "project[description]")
      end
    end
    
  end
end