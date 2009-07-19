require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "projects/new.html.erb" do
  before(:each) do
    render
  end
  it "should display a form" do
    response.should have_selector :form, attribute = {:action => new_project_path}
  end
  
  describe "new project form" do
    
    it "should have a title" do
      response.should have_tag("form[action=#{new_project_path}][method=post]") do
        with_tag('input#project_title[name=?]', "project[title]")
      end
    end
    
    it "should have a description" do
      response.should have_tag("form[action=#{new_project_path}][method=post]") do
        with_tag('textarea#project_description[name=?]', "project[description]")
      end
    end
    
    it "should have an aim" do
      response.should have_tag("form[action=#{new_project_path}][method=post]") do
        with_tag('textarea#project_aim[name=?]', "project[aim]")
      end
    end
    it "shold have a submit button" do
      response.should have_tag("form[action=#{new_project_path}][method=post]") do
        with_tag('input#project_submit[name=?]', "commit")
      end
    end
  end
end