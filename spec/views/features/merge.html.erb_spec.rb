require File.dirname(__FILE__) + '/../../spec_helper'

describe "/features/merge.html.erb" do
  
  context "feature file is newer than the system feature" do
    before(:each) do
      @feature = FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature").export
      File.open("#{RAILS_ROOT}/tmp/tag_cloud.feature", 'w') { |f| f.write(@feature.export) }
      @feature.save
      @feature.update_attribute(:path, "#{RAILS_ROOT}/spec/fixtures/features/tag_cloud.feature")
      assigns[:feature] = @feature
      assigns[:pretty] = @feature.diff
      render
    end
    
    it "should display the changes"do
      response.should contain "+Feature: Something different"
    end
    
    it "should have a link to do a dry-run" do
      response.should have_selector :a, :content => 'Dry-run'
    end
    it "should have a link to actually merge the changes" do
      response.should have_selector :a, :content => 'Patch'
    end
  end
end