require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FeaturesController do
  
  def mock_feature(stubs={})
    @mock_feature ||= mock_model(Feature, stubs)
  end

  describe "POST, create" do
    before(:each) do
      @feature = mock_model(Feature,:title=>"A new feature",:null_object=>true)
      request.env["HTTP_REFERER"] = projects_path mock_model(Project,:id=>1,:null_object=>true)
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
  
  describe "GET, show" do
    context "feature has been changed" do
      before(:each) do
        @feature = mock_model(Feature,:title=>"A new feature").as_null_object
        @feature.stub!(:is_diff?).and_return true
        Feature.stub!(:find).and_return @feature
        get :show, {:feature => @feature}
      end
      
      it "should generate a flash message if the feature has changed" do
        @feature.is_diff.should be_true
      end
    end
  end
end