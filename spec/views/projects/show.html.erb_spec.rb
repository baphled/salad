require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "projects/show.html.erb" do
  
  before(:each) do
    @date = Time.now
    @project = mock_model(Project,
                            :title => 'A project',
                            :description => 'A description',
                            :aim => 'An aim',
                            :created_at => @date).as_null_object
  end
  
  describe "a newly created project" do
    before(:each) do
      @project.stub(:updated_at).and_return nil
      assigns[:project] = @project
      render
    end
    
    it "should have a list the projects title" do
      response.should have_selector(:h3, :content => @project.title)
    end
  
    it "should have a description" do
      response.should have_selector :p, :content => @project.description
    end
  
    it "should have an aim" do
      response.should have_selector :p, :content => @project.aim
    end
  
    it "should display the created at field" do
      response.should contain "#{@project.creation_date}"
    end
    
    it "should display the date the project was updated" do
      response.should_not contain "Updated at: #{@project.updated_date}"
    end
  end  
  
  
  describe "a project is updated" do
    before(:each) do
      @project.stub(:updated_at).and_return @date.tomorrow
      assigns[:project] = @project
      render
    end
    
    it "should display the date the project was updated" do
      response.should contain "Updated at: #{@project.updated_date}"
    end
  end
  
  describe "showing a project with a location stored" do
    before(:each) do
      @project.stub!(:location).and_return "blah"
      assigns[:project] = @project
      render
    end
      
    it "should have an import link" do
      response.should have_selector :a, attribute = {:href => "/projects/#{@project.id}/import"}
    end
    
  end
  
  describe "showing a project without a location" do
    before(:each) do
      @project.stub!(:location).and_return nil
      assigns[:project] = @project
      render
    end
    it "should not have an import link" do
      response.should_not have_selector :a, attribute = {:href => "/projects/#{@project.id}/import"}
    end
  end
end