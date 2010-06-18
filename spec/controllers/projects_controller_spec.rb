require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProjectsController do
  before(:each) do
    @project = mock_model(Project).as_new_record.as_null_object
  end

  describe "GET, index" do
    it "should get a list of all projects" do
      Project.should_receive(:paginate)
      get :index
    end
  end

  describe "GET, new" do
    it "renders the new form template" do
      get :new
      response.should render_template :new
    end

    it "gets a list of features" do
      Feature.should_receive(:find).with(:all)
      get :new
    end

    it "should render the no sidebar layout" do
      get :new
      response.should use_layout("no_sidebar")
    end
  end

  describe "POST, create" do
    before(:each) do
      Project.stub!(:new).and_return @project
    end

    context "a valid project" do
      before(:each) do
        Project.stub!(:save).and_return true
      end
      
      it "should save the project" do
        @project.should_receive(:save).and_return true
        post :create
      end
    
      it "should display a flash message" do
        post :create
        flash.should contain "Project: #{@project.title} was created"
      end

      it "should save the project" do
        post :create
        response.should be_success
      end
    end

    context "an invalid project" do
      before(:each) do
        @project.stub(:save).and_return false
      end

      it "should not save the project" do
        @project.should_receive(:save).and_return false
        post :create
      end

      it "should render the new form" do
        post :create
        response.should render_template :new
      end
    end
  end

  describe "GET, edit" do
    before(:each) do
      Project.stub(:find).and_return @project
    end
    
    it "should find the project" do
      Project.should_receive(:find).and_return @project
      get :edit
    end

    it "should render the edit form template" do
      get :edit
      response.should render_template :edit
    end
  end

  describe "PUT, update" do
    before(:each) do
      @project.stub(:id).and_return 1
      Project.stub(:find).and_return @project
    end

    context "successfully update a project" do
      before(:each) do
        @project.stub(:update_attributes).and_return true
      end
      
      it "should update the project" do
        @project.should_receive(:update_attributes).with(@project)
        put :update, {:project => @project}
      end

      it "should display a flash message" do
        put :update, {:project => @project}
        flash[:notice].should contain "Project: #{@project.title} was updated"
      end

      it "should update the project" do
        put :update, {:project => @project}
        response.should be_success
      end
    end

    context "unsuccessfully update a project" do
      before(:each) do
        @project.stub(:update_attributes).and_return false
      end

      it "should not update the project" do
        @project.should_receive(:update_attributes).and_return false
        put :update, {:project => @project}
      end

      it "should display a flash[:error] message" do
        put :update, {:project => @project}
        flash[:error].should contain "Project: #{@project.title} was not created"
      end
      
      it "should render the edit form template" do
        put :update, {:project => @project}
        response.should render_template :edit
      end
    end
  end

  describe "GET, show" do
    before(:each) do
      Project.stub!(:find).and_return @project
    end
    it "should get the project" do
      Project.should_receive(:find).and_return @project
      get :show
    end
  end

  describe "GET, import_feature" do
    before(:each) do
      Project.stub(:find).and_return @project
    end
    
    context "features to import" do
      before(:each) do
        @results = [FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature").export]
        @feature = Feature.stub!(:imports_found).with("#{RAILS_ROOT}").and_return @results
        assigns[:to_import] = @feature
      end

      context "has a project path" do
        before(:each) do
          assigns[:project] = @project.stub(:location).and_return "#{RAILS_ROOT}"
          get :import_feature
        end

        it "should search all feature files" do
          assigns[:to_import].should_not be_empty
        end

        it "should have an array of features file locations" do
          assigns[:to_import].should == @results
        end
      end

    end

    context "does not have a project path" do
      before(:each) do
        Project.stub(:find).and_return @project
        assigns[:project] = @project.stub(:location).and_return nil
        get :import_feature
      end

      it "should not display a list of features to import" do
        assigns[:to_import].should be_empty
      end
    end
  end

  describe "DELETE, destroy" do
    before(:each) do
      Project.stub(:find).and_return @project
    end
    it "should find the project" do
      Project.should_receive(:find)
      delete :destroy, {:project => @project}
    end
    
    it "should destroy the project" do
      @project.should_receive(:destroy).and_return true
      delete :destroy
    end

    it "should redirect to the projects path" do
      delete :destroy
      response.should redirect_to projects_path
    end
  end

  describe "GET, features" do
    before(:each) do
      Project.stub(:find).and_return @project
    end
    
    it "should get the project" do
      Project.should_receive(:find).and_return @project
      get :features
    end

    it "should get all features related to the project" do
      @project.stub(:features).and_return mock_model(Feature).as_null_object
      @project.should_receive(:features)
      get :features
    end
  end

  describe "GET, import" do
    before(:each) do
      @results = [FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature").export]
      Feature.stub!(:imports_found).with("#{RAILS_ROOT}").and_return @results
      Project.stub(:find).and_return @project
    end

    it "should find the project" do
      Project.should_receive(:find).and_return @project
      get :import
    end
    
    it "should create a feature associated to the project" do
      @project.features.should_receive(:new)
      get :import
    end
    
    it "should retreive a list of features to import" do
      @project.should_receive(:import_features)
      get :import
    end
  end

  describe "GET, import_all" do
    before(:each) do
      @project = mock_model(Project,:location => "#{RAILS_ROOT}")
      @results = [FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature").export]
      Feature.stub!(:imports_found).with("#{RAILS_ROOT}").and_return @results
      Project.stub(:find).and_return @project
    end
    
    it "should make a call to import_feature" do
      Feature.should_receive(:imports_found)
      get :import_all
    end
  end
  
  describe "GET, tag" do
    it "should find all projects with the given tag" do
      Project.should_receive(:find_tagged_with)
      get :tag, {:tag => 'Given'}
    end
    
    it "shold render the index page" do
      get :tag
      response.should render_template :index
    end
  end
end