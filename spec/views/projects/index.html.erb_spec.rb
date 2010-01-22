require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/index.html.erb" do
  before(:each) do
    assigns[:tags] = []
  end

  context "No projects stored" do
    before(:each) do
      Project.stub!(:find).and_return []
      render
    end
    
    it "should display a message telling the user no projects are available" do
      response.should have_selector :li, :content => "No projects present"
    end
  end
  
  context "Projects are stored on the system" do
    before(:each) do
      @projects = []
      3.times { |project_number| @projects << mock_model(Project, :title => "Project number #{project_number}").as_null_object }
      assigns[:projects] = @projects
      render
    end
    
    it "should have a list of projects" do
      response.should have_selector :ul do |list|
        list.should have_selector :li do |content|
          content.should contain @projects.first.title
        end
      end
    end
    
    it "should display a created at field for each project" do
      @projects.each do |project|
        response.should contain "#{project.creation_date}"
      end
    end
  end
end