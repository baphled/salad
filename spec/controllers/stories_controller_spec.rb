# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StoriesController do
  before(:each) do
    @story = mock_model(Story, :save => nil).as_null_object
  end

  describe "GET, index" do
    it "gets a paginated list of stories" do
      Story.should_receive(:paginate).with(:page => "1", :per_page => 5)
      get :index, {:page => 1}
    end
  end
  
  describe "POST, create" do
    before(:each) do
      Story.stub(:new).and_return @story
    end

    context "valid" do
      before(:each) do
        @story.stub(:save).and_return true
      end

      it "gets a new story" do
        Story.should_receive(:new).
          with("scenario" => "a new scenario").and_return @story
        post :create, :story => {"scenario" => "a new scenario"}
      end

      it "is saved" do
        @story.should_receive(:save).and_return true
        post :create, :story => @story
      end

      it "displays a flash notice message" do
        post :create
        flash[:notice].should_not be_empty
      end
    end

    context "invalid" do
      before(:each) do
        Story.stub(:save).and_return false
      end

      it "renders the new template" do
        post :create
        response.should render_template("new")
      end
    end
  end

  describe "GET, show" do
    before(:each) do
      Story.stub(:find).and_return @story
    end

    it "finds the current story" do
      Story.should_receive(:find).and_return @story
      get :show, {:id => @story.id}
    end
    
    it "gets a list of associated steps" do
      @story.should_receive(:steps)
      get :show
    end
  end

  describe "GET, edit" do
    before(:each) do
      Story.stub(:find).and_return @story
    end

    it "finds the current story" do
      Story.should_receive(:find).and_return @story
      get :show, {:id => @story.id}
    end
  end

  describe "GET, new" do
    it "should create a new story" do
      Story.should_receive(:new)
      get :new
    end

    context "associated to a feature" do
      before(:each) do
        @feature = mock_model(Feature, :stories => mock_model(Story).as_null_object).as_null_object
        Feature.stub(:find).and_return @feature
      end
      
      it "finds the associated feature" do
        get :new, {:feature_id => 1}
      end

      it "creates a new story object" do
        @feature.stories.should_receive(:new)
        get :new, {:feature_id => 1}
      end
    end
  end

  describe "PUT, update" do
    before(:each) do
      Story.stub(:find).and_return @story
    end

    context "is successful" do
      before(:each) do
        @story.stub(:update_attributes).and_return true
      end
      
      it "updates the story" do
        @story.should_receive(:update_attributes).with(@story).and_return true
        post :update, {:story => @story}
      end

      it "displays a flash notice message" do
        post :update, {:story => @story}
        flash[:notice].should_not be_empty
      end
    end

    context "is unsucessful" do
      before(:each) do
        @story.stub(:update_attributes).and_return false
      end

      it "displays a flash error message" do
        post :update, :story => @story
        flash[:error].should_not be_empty
      end

      it "renders the edit template" do
        post :update, :story => @story
        response.should render_template(:edit)
      end
    end
  end

  describe "DELETE, destroy" do
    before(:each) do
      Story.stub(:find).and_return @story
    end

    it "deletes the story" do
      @story.should_receive :destroy
      delete :destroy
    end

    it "redirects to the stories page" do
      delete :destroy
      response.should redirect_to stories_path
    end
  end

  describe "GET, steps" do
    before(:each) do
      Story.stub(:find).and_return @story
    end
    
    it "gets the associated steps" do
      @story.should_receive(:steps)
      get :steps
    end
  end

  describe "GET, sort" do
    it "loops through each of the stories" do
      @story.should_receive(:each_with_index)
      get :sort, :story => @story
    end

    it "updates all stories" do
      @story.each { |story| story.should_receive(:update_all)}
    end
  end

  describe "GET, tag" do
    it "finds stories with tag" do
      Story.should_receive :find_tagged_with
      get :tag, {:tag => 'Given'}
    end

    it "renders the index template" do
      get :tag, {:tag => 'Given'}
      response.should render_template :index
    end
  end

  describe "GET, add_step" do
    before(:each) do
      Step.stub(:search).and_return [1,2,3]
    end
    
    it "searches for steps" do
      Step.should_receive(:search).with('Given')
      get :add_step, {:search_text => 'Given'}
    end

    context "a new story" do
      it "redirects to the new story form" do
        get :add_step, {:search_text => 'Given'}
        response.should redirect_to new_story_path(:step_ids => [1,2,3])
      end
    end

    context "editing a story" do
      before(:each) do
        Story.stub(:find).and_return @story
      end
      it "redirects to the edit story" do
        get :add_step, {:id => 1, :search_text => 'Given'}
        response.should redirect_to edit_story_path(:step_ids => [1,2,3])
      end
    end
  end
end