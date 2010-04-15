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
        @feature.should_receive(:diff_reverse)
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
  
  describe "GET, merge" do
    before(:each) do
      @feature.stub!(:is_diff?).and_return true
      Feature.stub(:find).and_return @feature
    end
    
    it "should display the changes" do
      @feature.stub(:diff).and_return nil
      @feature.should_receive(:diff)
      get :merge, {:feature => @feature}
    end
  end

  describe "GET, file_sync" do
    before(:each) do
      @feature = mock_model(Feature,:title=>"A new feature").as_null_object
      Feature.stub!(:find).and_return @feature
    end

    context "There are system change to sync to the file" do
      
      it "should redirect to the feature" do
        @feature.stub!(:sync).and_return false
        get :file_merge, {:feature => @feature, :dry_run => true}
        response.should redirect_to feature_path(@feature)
      end

      it "should make a call to the features sync method" do
        @feature.should_receive(:sync)
        get :file_merge, {:feature => @feature, :dry_run => true}
      end

      context "when sync is called" do
        before(:each) do
          @feature.stub!(:sync).and_return true
        end

        it "should return true if the changes were merged to the file" do
          @feature.should_receive(:sync).and_return true
          get :file_merge, {:feature => @feature, :dry_run => true}
        end

        it "should return false if the changes were not merged to the file" do
          @feature.stub!(:sync).and_return false
          @feature.should_receive(:sync).and_return false
          get :file_merge, {:feature => @feature, :dry_run => true}
        end
      end

      context "successfully merging changes with a dry-run" do
        before(:each) do
          @feature.stub!(:sync).and_return true
          get :file_merge, {:feature => @feature, :dry_run => true}
        end

        it "should display a successfully flash message" do
          flash.should contain 'No errors whilst doing dry-run'
        end
      end

      context "unsuccessfully merging changes with a dry-run" do
        before(:each) do
          @feature.stub!(:sync).and_return false
          get :file_merge, {:feature => @feature, :dry_run => true}
        end
        
        it "should display a error flash message" do
          flash.should contain 'Unable to merge changes'
        end
      end
      
      context "successfully patched a file" do
        before(:each) do
          @feature.stub!(:sync).and_return true
          get :file_merge, {:feature => @feature, :dry_run => false}
        end
        
        it "should display a success message" do
          flash.should contain 'Feature has been patched'
        end
        
        it "should redirect to the feature show action" do
          response.should redirect_to feature_path(@feature)
        end
      end
      
      context "unsuccessfully patched a file" do
        before(:each) do
          @feature.stub!(:sync).and_return false
          get :file_merge, {:feature => @feature, :dry_run => false}
        end
        
        it "should display a error message" do
          flash.should contain 'Errors encountered whilst patching file'
        end
        
        it "should redirect back to the features merge action" do
          response.should redirect_to merge_feature_path(@feature)
        end
      end
    end
  end

  describe "GET, system_sync" do
    before(:each) do
      @feature = mock_model(Feature,:title=>"A new feature").as_null_object
      Feature.stub!(:find).and_return @feature
    end
    
    it "makes a call to is_diff?" do
      @feature.should_receive(:is_diff?)
      get :system_merge, {:feature => @feature, :dry_run => true}
    end
    
    it "should redirect to the feature" do
      @feature.stub!(:is_diff?).and_return false
      get :system_merge, {:feature => @feature, :dry_run => true}
      response.should redirect_to feature_path(@feature)
    end

    context "feature is different" do
      before(:each) do
        @feature.stub!(:is_diff?).and_return true
      end
      
      it "should make a call to diff_reverse" do
        @feature.should_receive(:diff_reverse)
        get :system_merge, {:feature => @feature, :dry_run => true}
      end
      
      it "should not redirect" do
        response.should_not redirect_to feature_path(@feature)
      end
    end
    
    context "feature is not different" do
      before(:each) do
        @feature.stub!(:is_diff?).and_return false
      end
      
      it "should display a flash message" do
        get :system_merge, {:feature => @feature, :dry_run => true}
        flash.should contain "No changes available"
      end
      
      it "should redirect" do
        get :system_merge, {:feature => @feature, :dry_run => true}
        response.should redirect_to feature_path(@feature)
      end
    end
  end
end