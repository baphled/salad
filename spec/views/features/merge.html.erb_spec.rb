require File.dirname(__FILE__) + '/../../spec_helper'

describe "/features/merge.html.erb" do
  
  context "feature file is newer than the system feature" do
    before(:each) do      
      @feature = FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature").export
      @feature.save
      @feature.update_attribute(:path, "#{RAILS_ROOT}/spec/fixtures/features/tag_cloud.feature")
      assigns[:feature] = @feature
      assigns[:pretty] = @feature.diff
      render
    end
    
    it "should display the changes"do
      response.should contain "+Feature: A different title"
    end
    
    it "should have a link to do a dry-run" do
      response.should have_selector :a, :content => 'Dry-run'
    end
    it "should have a link to actually merge the changes"
  end
  
  context "system feature is newer than the feature file" do
    it "should display a flash message if the source file has newer content"    
  end
end