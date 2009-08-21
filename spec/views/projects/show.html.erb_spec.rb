require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "projects/show.html.erb" do
  
  before(:each) do
    @date = Time.now
  end
  
  describe "a newly created project" do
    before(:each) do
      @project = mock_model(Project,
                            :title => "A project",
                            :description => "The project description",
                            :aim => "The aim of this project is...",
                            :null_object=>true,
                            :created_at => @date,
                            :updated_at => @date)
      assigns[:project] = @project
      render
    end
    
    it "should have a list the projects title" do
      response.should have_selector(:h3, :content => "A project")
    end
  
    it "should have a description" do
      response.should have_selector :p, :content => "The project description"
    end
  
    it "should have an aim" do
      response.should have_selector :p, :content => "The aim of this project is..."
    end
  
    it "should display the created at field" do
      response.should contain "#{@project.created_at}"
    end
    
    it "should display the date the project was updated" do
      response.should_not contain "Updated at: #{@project.updated_at}"
    end
  end  
  
  
  describe "a project is updated" do
    before(:each) do
      @project = mock_model(Project,
                            :title => "A project",
                            :description => "The project description",
                            :aim => "The aim of this project is...",
                            :created_at => @date,
                            :null_object=>true)
      @project.update_attribute(:description => "something different")
      assigns[:project] = @project
      render
    end
    
    it "should display the date the project was updated" do
      response.should contain "Updated at: #{@project.updated_at}"
    end
  end
  
  describe "showing a project" do
    before(:each) do
      @project = mock_model(Project,:id=>1,:null_object=>true)
      assigns[:project] = @project
      render
    end
      
    it "should have an import link" do
      response.should have_selector :a, attribute = {:href => "/projects/#{@project.id}/import"}
    end
    
  end
end