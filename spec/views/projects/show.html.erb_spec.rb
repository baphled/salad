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
  
  describe "a project is updated" do
    before(:each) do
      @project.stub(:updated_at).and_return @date.tomorrow
      assigns[:project] = @project
      render
    end
    
    it "should display the date the project was updated" do
      response.should contain "Updated date: #{@project.updated_date}"
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

  context "features to import" do

    context "no features to import" do
      before(:each) do
        assigns[:project] = @project
        render
      end
      it "should not display a list of feature files to import" do
        response.should_not have_selector :ul, attribute = {:id => 'import_list'}
      end
    end

    context "new features to import" do
      before(:each) do
        assigns[:project] = @project
        assigns[:to_import] = [FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature").export]
        render
      end

      it "has a list of feature files to import" do
        response.should have_selector :ul, attribute = {:id => 'import_list'}
      end

      it "should have a link to import that feature" do
        response.should have_selector :a, :content => "Import #{File.basename(assigns[:to_import].first.path).sub('.feature', '').gsub('_',' ')}"
      end
    end
  end
end