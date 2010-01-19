require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FeatureFile do
  before(:each) do
    @feature_file = FeatureFile.new("#{RAILS_ROOT}/spec/fixtures/projects.yml")
  end

  it "should be a child of the File object" do
    @feature_file.should be_a File
  end

  it "should be invalid" do
    @feature_file.should be_invalid
  end

  context "a valid feature file" do
    before(:each) do
      @feature_file = FeatureFile.new("#{RAILS_ROOT}/spec/fixtures/test.feature")
    end

    it "should be valid if the file is a feature file" do
      @feature_file.should_not be_invalid
    end

    it "should store the feature heading within the feature properties" do
      @feature_file.feature.should_not be_nil
    end
  end
end