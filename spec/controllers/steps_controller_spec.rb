require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StepsController do
  before(:each) do
    @step = mock_model(Step).as_null_object
  end

  describe "GET, new" do
    
    context "associated to a story" do
      before(:each) do
        @story = mock_model(Story).as_null_object
        Story.stub(:find).and_return @story
      end
      
      it "finds the associated story" do
        Story.should_receive(:find).with("1").and_return @story
        get :new, {:story_id => 1}
      end
      
      it "creates a new step associated to the story" do
        @story.steps.should_receive(:new).with(:story_ids => ["1"])
        get :new, {:story_id => 1}
      end
    end

    context "not associated to a story" do
      it "creates a new story" do
        Step.should_receive(:new)
        get :new
      end
    end
  end

  describe "GET, index" do
    it "has a list of steps" do
      Step.should_receive(:paginate)
      get :index
    end

    context "searching for a step" do
      it "searches for steps" do
        Step.should_receive(:search).with('Given')
        get :index, {:search_text => 'Given'}
      end
    end
  end

  describe "POST, create" do
    before(:each) do
      Step.stub(:new).and_return @step
    end
    
    it "creates a new step" do
      Step.should_receive(:new).with(@step)
      post :create, {:step => @step}
    end

    context "valid step" do
      before(:each) do
        @step.stub(:save).and_return true
      end

      it "saves the step" do
        @step.should_receive(:save).and_return true
        post :create
      end

      it "displays a flash notice message" do
        post :create
        flash[:notice].should_not be_empty
      end

      it "is saved" do
        post :create
        response.should be_success
      end
    end

    context "invalid step" do
      before(:each) do
        @step.stub(:save).and_return false
      end
      
      it "is not saved" do
        @step.should_receive(:save).and_return false
        post :create
      end

      it "renders the new form" do
        post :create
        response.should render_template :new
      end
    end
  end

  describe "GET, edit" do
    it "finds the step" do
      Step.stub(:find).and_return @step
      Step.should_receive(:find)
      get :edit
    end
  end

  describe "PUT, update" do
    before(:each) do
      Step.stub(:find).and_return @step
    end
    
    context "successfully updates" do
      before(:each) do
        @step.stub(:update_attributes).and_return true
      end

      it "is updated" do
        @step.should_receive(:update_attributes).and_return true
        put :update, {:step => @step}
      end

      it "displays a flash notice message" do
        put :update, {:step => @step}
        flash[:notice].should_not be_empty
      end

      it "is saved" do
        put :update, {:step => @step}
        response.should be_success
      end

    end

    context "unsuccessfully updates" do
      before(:each) do
        @step.stub(:update_attributes).and_return false
      end

      it "displays a flash error message" do
        put :update, {:step => @step}
        flash[:error].should_not be_empty
      end

      it "renders the edit form" do
        put :update, {:step => @step}
        response.should render_template :edit
      end
    end
  end

  describe "DELETE, destroy" do
    before(:each) do
      Step.stub(:find).and_return @step
    end

    it "finds the step" do
      Step.should_receive(:find).and_return @step
      delete :destroy
    end

    context "found step" do
      it "destroys the step" do
        @step.should_receive(:destroy).and_return true
        delete :destroy
      end

      it "redirects to the steps" do
        delete :destroy
        response.should redirect_to steps_path
      end
    end
  end

  describe "GET, sort" do
    it "should loop through each of the steps" do
      @step_ids = Step.stub(:find).with(["2", "1", "3"])
      @step_ids.should_receive(:each_with_index)
      get :sort, {:step => @step_ids}
    end
  end

end