require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "projects/import_feature.html.erb" do
  before(:each) do
    @project = mock_model(Project)
  end
  
  context "with no features to import" do
    before(:each) do
      assigns[:project] = @project
      render
    end
    it "does not display a list of feature files" do
      response.should_not have_selector :ul, attribute = {:id => 'import_list'}
    end
  end

  context "with features to import" do
    before(:each) do
      assigns[:project] = @project
      assigns[:to_import] = [FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature").export]
      render
    end

    it "has a list of feature files" do
      response.should have_selector :ul, attribute = {:id => 'import_list'}
    end

    it "has a link to import feature" do
      response.should have_selector :a,
        :content => "Import #{File.basename(assigns[:to_import].first.path).sub('.feature', '').gsub('_',' ')}"
    end
  end
end