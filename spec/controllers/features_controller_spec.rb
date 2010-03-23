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
    before(:each) do
      @feature = mock_model(Feature,:title=>"A new feature").as_null_object
      Feature.stub!(:find).and_return @feature
      get :show, {:feature => @feature}
    end
    
    context "feature has been changed" do
      before(:each) do
        @feature.stub!(:is_diff?).and_return true
      end
      
      it "should generate a flash message if the feature has changed" do
        @feature.is_diff.should be_true
      end
      
      it "should display the patch file" do
        response.body.should_not be_empty
      end
    end
    
    context "a feature that has no changes" do
      before(:each) do
        @feature.stub!(:is_diff?).and_return false
        get :show, {:feature => @feature, :format => :patch}
      end

      it "expects is_diff to be false" do
        @feature.is_diff?.should be_false
      end

      it "should redirect" do
        pending 'Have an issue with testing our redirect'
        response.should redirect_to feature_path(@feature)
      end
    end

    context "there are features to import" do
      context "no features to import" do
        before(:each) do
          Feature.stub!(:imports_found).and_return []
          get :show
        end
        it "should have an empty list" do
          Feature.imports_found.should be_empty
        end
      end

      context "features to import" do
        before(:each) do
          Feature.stub!(:imports_found).and_return ["#{RAILS_ROOT}/features/plain/tag_cloud.feature"]
          get :show
        end
        
        it "should search all feature files" do
          Feature.imports_found.should_not be_empty
        end
      
        it "should have an array of features file locations" do
          Feature.imports_found.first.should == "#{RAILS_ROOT}/features/plain/tag_cloud.feature"
        end
      end
    end
  end

  describe "GET, changes" do
    before(:each) do
      @feature = mock_model(Feature,:title=>"A new feature")
      Feature.stub(:find).and_return @feature
    end

    context "has changes" do
      before(:each) do
        @feature.stub!(:is_diff?).and_return true
      end
      
      it "should display the changes" do
        @feature.should_receive(:diff)
        get :changes, {:feature => @feature}
      end
    end
    
    context "has no changes" do
      before(:each) do
        @feature.stub!(:is_diff?).and_return false
      end
      
      it "should redirect to the feature" do
        get :changes, {:feature => @feature}
        response.should redirect_to feature_path(@feature)
      end
    end
  end
end