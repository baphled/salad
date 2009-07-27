require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FeaturesController do
  describe "POST, create" do
    before(:each) do
      @feature = mock_model(Feature,:title=>"A new feature",:null_object=>true)
      Feature.stub!(:new).and_return @feature
      
    end
    context "the feature is valid" do
      before(:each) do
        @feature.stub!(:save).and_return true
      end
      it "should save the feature" do
        @feature.save.should eql true
        post :create
      end
      
    end
    
    context "the feature is invalid" do
      before(:each) do
        @feature.stub!(:title).and_return nil
        post :create
      end
      it "should not save if the title is not present" do
        @feature.save.should_not eql true
      end
      
    end
  end
end