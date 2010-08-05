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
  
  context "has been updated updated" do
    before(:each) do
      @project.stub(:updated_at).and_return @date.tomorrow
      assigns[:project] = @project
      render
    end
    
    it "displays its date" do
      response.should contain "Updated date: #{@project.updated_date}"
    end
  end
  
  context "has a location" do
    before(:each) do
      @project.stub!(:location).and_return "blah"
      assigns[:project] = @project
      render
    end
      
    it "has an import link" do
      response.should have_selector :a, attribute = {:href => "/projects/#{@project.id}/import"}
    end
    
  end
  
  context "without a location" do
    before(:each) do
      @project.stub!(:location).and_return nil
      assigns[:project] = @project
      render
    end
    
    it "does not have an import link" do
      response.should_not have_selector :a, attribute = {:href => "/projects/#{@project.id}/import"}
    end
    
    it "does not have an import all link" do
      response.should_not have_selector :a, attribute = {:href => "/projects/#{@project.id}/import_all"}
    end
  end
  
  context "with features to import" do
    before(:each) do
      @project.stub(:find).and_return @project
      assigns[:project] = @project
      render
    end
    
    it "displays a link to import all features" do
      response.should have_selector :a, attribute = {:href => import_all_project_path(@project)}
    end
  end
  
  context "with no features to import" do
    before(:each) do
      @project.stub(:find).and_return @project
      assigns[:project] = @project
      @project.stub!(:location).and_return "#{RAILS_ROOT}"
      @project.stub!(:features_to_import?).and_return false
      render
    end

    it "does not display the import link" do
      response.should_not have_selector :a, attribute = {:id => 'import'}
    end
    
    it "does not have an import all link" do
      response.should_not have_selector :a, attribute = {:href => "/projects/#{@project.id}/import_all"}
    end
  end
end