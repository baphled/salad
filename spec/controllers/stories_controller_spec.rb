# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StoriesController do
  before(:each) do
    @story = mock_model(Story, :save => nil).as_null_object
    Story.stub(:new).and_return @story
  end

  describe "POST, create" do

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

end

