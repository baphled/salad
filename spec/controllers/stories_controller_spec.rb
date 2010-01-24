# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StoriesController do
  before(:each) do
    @story = mock_model(Story, :save => nil).as_null_object
  end

  describe "GET, index" do
    it "should have a list of stories" do
      Story.should_receive(:paginate).
        with(:page => "1", :per_page => 10)
      get :index, {:page => 1}
    end
  end
  
  describe "POST, create" do

    before(:each) do
      Story.stub(:new).and_return @story
    end

    context "a valid story" do
      before(:each) do
        @story.stub(:save).and_return true
      end

      it "should create a new story" do
        Story.should_receive(:new).
          with("scenario" => "a new scenario").and_return @story
        post :create, :story => {"scenario" => "a new scenario"}
      end

      it "should save the story" do
        @story.should_receive(:save).and_return true
        post :create, :story => @story
      end

      it "should display a flash[:notice] message" do
        post :create
        flash[:notice].should contain "Story: #{@story.scenario}, was created"
      end

      it "should redirect to the stories page" do
        post :create
        response.should redirect_to stories_path
      end
    end

    context "an invalid story" do
      before(:each) do
        Story.stub(:save).and_return false
      end

      it "should render the new template" do
        post :create
        response.should render_template("new")
      end
    end
  end

  describe "GET, show" do
    before(:each) do
      Story.stub(:find).and_return @story
    end

    it "should find the current story" do
      Story.should_receive(:find).and_return @story
      get :show, {:id => @story.id}
    end
    
    it "should have a list of associated steps" do
      @story.should_receive(:steps)
      get :show
    end
  end

  describe "GET, edit" do
    before(:each) do
      Story.stub(:find).and_return @story
    end

    it "should find the current story" do
      Story.should_receive(:find).and_return @story
      get :show, {:id => @story.id}
    end
  end

  describe "GET, new" do
    context "not associated to a feature" do
      it "should create a new story" do
        Story.should_receive(:new)
        get :new
      end
    end

    context "is associated with a feature" do
      before(:each) do
        @feature = mock_model(Feature, :stories => mock_model(Story).as_null_object).as_null_object
        Feature.stub(:find).and_return @feature
      end
      
      it "should find the associated feature" do
        get :new, {:feature_id => 1}
      end

      it "should create a new story, associated to the feature" do
        @feature.stories.should_receive(:new)
        get :new, {:feature_id => 1}
      end
    end

    context "has step ids" do
      it "should appended selected to associated steps"
    end
  end

  describe "POST, update" do
    context "successful" do
      it "should update the story"
      it "should display a flash[:notice] message"
      it "should redirect to the updated story"
    end

    context "unsucessful" do
      it "should display a flash[:error] message"
      it "should render the edit template"
    end
  end

  describe "GET, steps" do
    it "should have a list of associated steps"
  end
end

