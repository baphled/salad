require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/index.html.erb" do
  before(:each) do
    assigns[:tags] = []
  end

  context "with no projects" do
    before(:each) do
      Project.stub!(:find).and_return []
      render
    end
    
    it "displays a message telling the user" do
      response.should have_selector :li, :content => "No projects present"
    end
  end
  
  context "with projects" do
    before(:each) do
      @projects = []
      3.times { |project_number| @projects << mock_model(Project, :title => "Project number #{project_number}").as_null_object }
      assigns[:projects] = @projects
      assigns[:projects].stub(:total_pages).and_return 1
      render
    end
    
    it "has a list of projects" do
      response.should have_selector :ul do |list|
        list.should have_selector :li do |content|
          content.should contain @projects.first.title
        end
      end
    end

    describe "each project" do
      it "displays a created at field" do
        @projects.each do |project|
          response.should contain "#{project.creation_date}"
        end
      end
    end
  end
end