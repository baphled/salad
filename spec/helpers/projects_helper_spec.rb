require 'spec_helper'

# @TODO Refactor the signature to make it more expressive
def setup_features unique = true
  stories = []
    3.times do |value|
      scenario = (unique)? "something thats unique#{value}" : "something thats not unique"
      stories << mock_model(Story,:scenario => scenario)
    end

  @feature.stub!(:stories).and_return stories
  @feature_import = [{:file => 'foo', :feature => @feature}]
end

describe ProjectsHelper do
  before(:each) do
    @feature = stub_model(Feature).as_null_object
  end

  describe  "#has_duplicate_feature?(:list)" do

    context "a single feature" do

      context "with no duplicate scenario's" do
        before(:each) do
          setup_features
        end

        it "returns true" do
          helper.has_duplicate_feature?('foo',@feature_import).should be_false
        end
      end

      context "with duplicate scenario's" do
        before(:each) do
          setup_features false
        end

        it "should return false" do
          helper.has_duplicate_feature?('foo', @feature_import).should be_true
        end
      end
    end

    context "mutlple features" do

      context "with duplicate scenarios" do
        before(:each) do
          setup_features false
        end

        it "returns true" do
          helper.has_duplicate_feature?('foo', @feature_import).should be_true
        end
      end

      context "with no duplicates" do
        before(:each) do
          setup_features
        end

        it "returns false" do
          helper.has_duplicate_feature?('foo', @feature_import).should be_false
        end
      end
    end
  end

  describe  "#has_duplicate_feature_name?(:list)" do
    before(:each) do
      @feature.stub!(:path).and_return "#{RAILS_ROOT}/spec/fixtures/features/sample_one.feature"
    end

    context "does not share name with another feature" do
      it "returns false" do
        @feature_import = [{:file => "#{RAILS_ROOT}/spec/fixtures/features/sample_one.feature", :feature => @feature}]
        helper.has_duplicate_feature_name?("#{RAILS_ROOT}/spec/fixtures/features/sample_one.feature", @feature_import).should be_false
      end
    end
    context "shares name with another feature" do
      it "returns true" do
        @feature_import = [{:file => "#{RAILS_ROOT}/spec/fixtures/features/sample_one.feature", :feature => @feature}, {:file => "#{RAILS_ROOT}/spec/fixtures/features/duplicates/sample_one.feature", :feature => @feature}]
        helper.has_duplicate_feature_name?("#{RAILS_ROOT}/spec/fixtures/features/duplicates/sample_one.feature", @feature_import).should == "#{RAILS_ROOT}/spec/fixtures/features/duplicates/sample_one.feature"
      end
    end
  end
  
end