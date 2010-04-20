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

    it "should have a link to update the system feature" do
      response.should have_selector :a, attributes = {:href => system_sync_feature_path(@feature)}
    end

    it "should have a legend displaying system changes as green" do
      response.should have_selector :div, attribute = {:class => "legend highlighttable"} do |legend_wrapper|
        legend_wrapper.should have_selector :p, attribute = {:class => "gi"} do |content|
          content.should contain "Adding to system"
        end
      end
    end

    it "should have a legend displaying file changes as red" do
      response.should have_selector :div, attribute = {:class => "legend highlighttable"} do |legend_wrapper|
        legend_wrapper.should have_selector :p, attribute = {:class => "gd"} do |content|
          content.should contain "Removing from system"
        end
      end
    end
  end
end