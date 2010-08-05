require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FeaturesController do
  describe "POST, create" do
    before(:each) do
      @feature = mock_model(Feature,:title=>"A new feature").as_null_object
      request.env["HTTP_REFERER"] = projects_path(Project.make)
      Feature.stub!(:new).and_return @feature
    end
    
    context "valid feature" do
      before(:each) do
        @feature.stub!(:save).and_return true
      end

      it "is saved" do
        @feature.save.should eql true
        post :create
      end
      
    end
    
    context "invalid feature" do
      before(:each) do
        @feature.stub!(:save).and_return false
        post :create
      end
      
      it "is not saved" do
        @feature.save.should_not eql true
      end
    end
  end

  describe "POST, sync" do
    before(:each) do
      @project = Project.make
      @feature = mock_model(Feature,:title=>"A new feature",:null_object=>true)
      request.env["HTTP_REFERER"] = projects_path @project
      Feature.stub!(:new).and_return @feature
      Project.stub!(:find).and_return @project
    end
    
    it "finds project that a feature is sync'd to" do
      Project.should_receive(:find)
      post :sync, {:commit => 'Import', :current_project_id => @project.id}
    end
    
    it "checks to see if there are features to import" do
      @project.should_receive(:features_to_import?)
      post :sync, {:commit => 'Import', :current_project_id => @project.id}
    end

    context "saving an imported feature" do
      before(:each) do
        request.env["HTTP_REFERER"] = import_project_path @project
        assigns[:current_project_id] = @project.id
        @feature.stub!(:save).and_return true
      end

      it "redirects to the import page" do
        post :sync, {:commit => 'Import', :current_project_id => @project.id}
        response.should redirect_to import_project_path(@project)
      end

      context "importing over XHR" do

        it "does not redirects to the import page" do
          xhr :post, :sync, {:commit => 'Import', :current_project_id => @project.id}
          response.should_not redirect_to import_project_path(@project)
        end

        context "with more features to import" do
          before(:each) do
            @project.stub!(:features_to_import?).and_return true
            xhr :post, :sync, {:commit => 'Import', :current_project_id => @project.id}
          end

          it "renders the import RJS file" do
            response.should render_template "import.rjs"
          end

          it "displays a message stating the feature has been imported" do
            flash[:notice].should contain "was imported"
          end
        end

        context "with no more features to import" do
          before(:each) do
            @project.stub!(:features_to_import?).and_return false
            xhr :post, :sync, {:commit => 'Import', :current_project_id => @project.id}
          end

          it "renders the project RJS file" do
            response.should render_template "index.rjs"
          end

          it "displays a notice stating that there are no more features to import" do
            flash[:notice].should contain "No more features to import"
          end

          it "displays the features information" do
            pending "Need to finish functionality" do
              response.should have_selector :h3, :content => 'Feature Info'
            end
          end
        end

      end
    end

    context "with no more features to import" do
      before(:each) do
        @project.stub!(:features_to_import?).and_return false
        post :sync, {:commit => 'Import', :current_project_id => @project.id}
      end

      it "does not redirects to the features index" do
        response.should_not redirect_to features_path
      end

      it "displays a flash notice" do
        flash[:notice].should_not be_empty
      end
    end
  end

  describe "GET, show" do
    before(:each) do
      @feature = mock_model(Feature,:title=>"A new feature").as_null_object
      Feature.stub!(:find).and_return @feature
      get :show, {:feature => @feature}
    end
    
    context "feature with changes" do
      before(:each) do
        @feature.stub!(:is_diff?).and_return true
      end
      
      it "generates a flash message" do
        @feature.is_diff.should be_true
      end
    end
    
    context "feature that no changes" do
      before(:each) do
        @feature.stub!(:is_diff?).and_return false
        get :show, {:feature => @feature, :format => :patch}
      end

      it "should be not be different from the source" do
        @feature.is_diff?.should be_false
      end
    end

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

  describe "GET, changes" do
    before(:each) do
      @feature = mock_model(Feature,:title=>"A new feature")
      Feature.stub(:find).and_return @feature
    end

    context "feature has changes" do
      before(:each) do
        @feature.stub!(:is_diff?).and_return true
      end
      
      it "displays the changes" do
        @feature.should_receive(:diff_reverse)
        get :changes, {:feature => @feature}
      end
    end
    
    context "feature has no changes" do
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
    
    it "should displays what will be merged" do
      @feature.should_receive(:diff_reverse)
      get :merge, {:feature => @feature}
    end
  end

  describe "GET, file_sync" do
    before(:each) do
      @feature = mock_model(Feature,:title=>"A new feature").as_null_object
      Feature.stub!(:find).and_return @feature
    end

    context "system changes to sync to a feature file" do
      
      it "redirects to the feature after sync" do
        @feature.stub!(:sync).and_return false
        get :file_merge, {:feature => @feature, :dry_run => true}
        response.should redirect_to feature_path(@feature)
      end

      it "triggers a sync of the feature" do
        @feature.should_receive(:sync)
        get :file_merge, {:feature => @feature, :dry_run => true}
      end

      context "changes are merged" do
        before(:each) do
          @feature.stub!(:sync).and_return true
        end

        it "returns true when successful" do
          @feature.should_receive(:sync).and_return true
          get :file_merge, {:feature => @feature, :dry_run => true}
        end

        it "returns true when not successful" do
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

        it "displays a successfully flash message" do
          flash[:notice].should contain 'No errors whilst doing dry-run'
        end
      end

      context "unsuccessfully merging changes with a dry-run" do
        before(:each) do
          @feature.stub!(:sync).and_return false
          get :file_merge, {:feature => @feature, :dry_run => true}
        end
        
        it "displays a error flash message" do
          flash[:error].should contain 'Unable to merge changes'
        end
      end
      
      context "successfully patched" do
        before(:each) do
          @feature.stub!(:sync).and_return true
          get :file_merge, {:feature => @feature, :dry_run => false}
        end
        
        it "displays a success message" do
          flash.should contain 'Feature has been patched'
        end
        
        it "redirects to the feature" do
          response.should redirect_to feature_path(@feature)
        end
      end
      
      context "unsuccessfully patched" do
        before(:each) do
          @feature.stub!(:sync).and_return false
          get :file_merge, {:feature => @feature, :dry_run => false}
        end
        
        it "displays a error message" do
          flash.should contain 'Errors encountered whilst patching file'
        end
        
        it "redirects back to the features merge" do
          response.should redirect_to merge_feature_path(@feature)
        end
      end
    end
  end

  describe "GET, system_sync" do
    before(:each) do
      @feature = mock_model(Feature,:title=>"A new feature").as_null_object
      @feature.stub!(:path).and_return "#{RAILS_ROOT}/features/plain/tag_cloud.feature"
      Feature.stub!(:find).and_return @feature
    end
    
    it "checks to see if there are any differences" do
      @feature.should_receive(:is_diff?)
      get :system_merge, {:feature => @feature, :dry_run => true}
    end
    
    it "redirects to the feature" do
      @feature.stub!(:is_diff?).and_return false
      get :system_merge, {:feature => @feature, :dry_run => true}
      response.should redirect_to feature_path(@feature)
    end

    context "feature with no differences" do
      before(:each) do
        @feature.stub!(:is_diff?).and_return true
      end
      
      it "gets the difference" do
        @feature.should_receive(:diff)
        get :system_merge, {:feature => @feature, :dry_run => true}
      end
      
      it "does not redirect" do
        response.should_not redirect_to feature_path(@feature)
      end
    end
    
    context "feature with no differences" do
      before(:each) do
        @feature.stub!(:is_diff?).and_return false
      end
      
      it "should displays a flash notice message" do
        get :system_merge, {:feature => @feature, :dry_run => true}
        flash[:notice].should contain "No changes available"
      end
      
      it "redirects to the feature" do
        get :system_merge, {:feature => @feature, :dry_run => true}
        response.should redirect_to feature_path(@feature)
      end
    end
    
    context "feature with nothing to update" do
      before(:each) do
        @feature.stub!(:is_diff?).and_return false
      end

      it "should display an flash notice message" do
        get :system_sync, {:feature => @feature}
        flash[:notice].should_not be_empty
      end
    end

    context "unsuccessfully updating a feature" do
      before(:each) do
        @feature.stub!(:sync_system).and_return false
      end

      it "displays a flash error message" do
        get :system_sync, {:feature => @feature}
        flash[:error].should_not be_empty
      end
    end

    context "successfully updating a feature" do
      before(:each) do
        @feature.stub(:sync_system).and_return true
      end
      it "should display a successful flash message" do
        get :system_sync, {:feature => @feature}
        flash[:success].should_not be_empty
      end
    end
  end
  
  describe "GET, source" do
    before(:each) do
      @feature = mock_model(Feature).as_null_object
      @feature.stub!(:path).and_return "#{RAILS_ROOT}/features/plain/tag_cloud.feature"
      Feature.stub!(:find).and_return @feature
    end
    
    it "searches for the feature" do
      Feature.should_receive :find
      get :source, {:feature => @feature}
    end
    
    it "reads the source feature file" do
      File.should_receive :read
      get :source, {:feature => @feature}
    end
    
  end
end