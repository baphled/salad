require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "projects/show.html.erb" do
  before(:each) do
    @project = mock_model(Project,
                          :title => "A project",
                          :description => "The project description")
    assigns[:project] = @project
    render
  end
  
  it "should have a list the projects title" do
    response.should have_selector(:h3, :content => "A project")
  end
  
  it "should have a description" do
    response.should have_selector :p, :content => "The project description"
  end
  
  it "should have an aim"
end