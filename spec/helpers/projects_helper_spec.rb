require 'spec_helper'

describe ProjectsHelper do

  describe  "#has_duplicate_feature?(:list)" do
    before(:each) do
      @feature = mock_model(Feature).as_null_object
    end
    
    context "When there are no duplicate scenario's" do
      before(:each) do
        stories = []
        3.times { |value| stories << mock_model(Story,:scenario => "something thats unique#{value}")}
        @feature.stub!(:stories).and_return stories
        @feature_import = [:file => 'foo', :feature => @feature]
      end
      
      it "should return true" do
        helper.has_duplicate_feature?(@feature_import).should be_false
      end
    end

    context "When there are duplicate scenario's" do
      before(:each) do
        @stories = []
        3.times { |value| @stories << mock_model(Story,:scenario => "something thats not unique")}
        @feature.stub!(:stories).and_return @stories
        @feature_import = [:file => 'foo', :feature => @feature]
      end
      
      it "should return false" do
        helper.has_duplicate_feature?(@feature_import).should be_true
      end
    end
  end

end