require File.dirname(__FILE__) + '/../../spec_helper'

describe "features/system_merge.html.erb" do

  describe "GET, system_merge" do
    before(:each) do
      @feature = FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature").export
      File.open("#{RAILS_ROOT}/tmp/tag_cloud.feature", 'w') { |f| f.write(@feature.export) }
      @feature.update_attribute(:path, "#{RAILS_ROOT}/spec/fixtures/features/tag_cloud.feature")
      assigns[:feature] = @feature
      assigns[:pretty] = @feature.diff_reverse
      render
    end

    it "has a link to update the system feature" do
      response.should have_selector :a, attributes = {:href => system_sync_feature_path(@feature)}
    end
  end
end