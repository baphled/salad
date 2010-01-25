require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProjectsController do
  before(:each) do
    @project = mock_model(Project).as_new_record.as_null_object
  end

  describe "GET, index" do
    it "should get a list of all projects" do
      Project.should_receive(:find).with(:all)
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
  end

  describe "POST, create" do
    before(:each) do
      Project.stub!(:new).and_return @project
    end

    context "a valid project" do
      it "should save the project" do
        @project.should_receive(:save).and_return true
        post :create
      end
    
      it "should display a flash message" do
        post :create
        flash.should contain "Project: #{@project.title} was created"
      end

      it "should redirect to the projects page" do
        post :create
        response.should redirect_to projects_path
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

      it "should redirect to the project" do
        put :update, {:project => @project}
        response.should redirect_to projects_path
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
    it "should get the project"
  end

  describe "DELETE, destroy" do
    it "should find the project"
    it "should destroy the project"
    it "should redirect to the projects path"
  end

  describe "GET, features" do
    it "should get the project"
    it "should get all features related to the project"
  end

  describe "GET, import" do
    it "should find the project"
    it "should create a feature associated to the project"
    it "should retreive a list of features to import"
  end

  describe "GET, tag" do
    it "should find all projects with the given tag"
    it "shold render the index page"
  end
end