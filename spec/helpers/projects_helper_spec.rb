require 'spec_helper'

describe ProjectsHelper do
  before(:each) do
    @feature = stub_model(Feature).as_null_object
  end

  describe  "#has_duplicate_feature?(:list)" do    
    context "When there a single feature are no duplicate scenario's" do
      before(:each) do
        stories = []
        3.times { |value| stories << mock_model(Story,:scenario => "something thats unique#{value}")}
        @feature.stub!(:stories).and_return stories
        @feature_import = [{:file => 'foo', :feature => @feature}]
      end
      
      it "should return true" do
        helper.has_duplicate_feature?('foo',@feature_import).should be_false
      end
    end

    context "When there a single feature are duplicate scenario's" do
      before(:each) do
        @stories = []
        3.times { |value| @stories << mock_model(Story,:scenario => "something thats not unique")}
        @feature.stub!(:stories).and_return @stories
        @feature_import = [{:file => 'foo', :feature => @feature}]
      end
      
      it "should return false" do
        helper.has_duplicate_feature?('foo', @feature_import).should be_true
      end
    end
    
    context "When there are multiple features which have scenarios that are duplicate" do
      before(:each) do
        story = mock_model(Story,:scenario => "something thats not unique")
        @feature.stub!(:stories).and_return [story]
        @feature_import = [{:file => 'foo', :feature => @feature}, {:file => 'bar', :feature => @feature}]
      end
      
      it "should return true" do
        helper.has_duplicate_feature?('bar', @feature_import).should be_true
      end
    end

    context "When there are multiple features which don't have scenarios that are duplicate" do
      before(:each) do
        story = mock_model(Story,:scenario => "something thats different")
        newFeature = mock_model(Feature).as_null_object
        newFeature.stub!(:stories).and_return [story]
        @feature_import = [{:file => 'foo', :feature => @feature}, {:file => 'bar', :feature => newFeature}]
      end
      
      it "should return false" do
        helper.has_duplicate_feature?('foo', @feature_import).should be_false
      end
    end
  end
  describe  "#has_duplicate_feature_name?(:list)" do

    before(:each) do
      @feature.stub!(:path).and_return "#{RAILS_ROOT}/spec/fixtures/features/sample_one.feature"
    end
    
    it "should return false if the feature shares its name wuth another feature" do
      @feature.stub!(:path).and_return "#{RAILS_ROOT}/spec/fixtures/features/sample_one.feature"
      @feature_import = [{:file => "#{RAILS_ROOT}/spec/fixtures/features/sample_one.feature", :feature => @feature}]
      helper.has_duplicate_feature_name?("#{RAILS_ROOT}/spec/fixtures/features/sample_one.feature", @feature_import).should be_false
    end
    
    it "should return true if the feature shares its name with another feature" do
      @feature_import = [{:file => "#{RAILS_ROOT}/spec/fixtures/features/sample_one.feature", :feature => @feature}, {:file => "#{RAILS_ROOT}/spec/fixtures/features/duplicates/sample_one.feature", :feature => @feature}]
      helper.has_duplicate_feature_name?("#{RAILS_ROOT}/spec/fixtures/features/duplicates/sample_one.feature", @feature_import).should == "#{RAILS_ROOT}/spec/fixtures/features/duplicates/sample_one.feature"
    end
  end
  
end