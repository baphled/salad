# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StepsController do
  describe "GET, new" do
    
    context "is associated to a story" do
      before(:each) do
        @story = mock_model(Story).as_null_object
        Story.stub(:find).and_return @story
      end
      
      it "should find the associated story" do
        Story.should_receive(:find).with("1").and_return @story
        get :new, {:story_id => 1}
      end
      
      it "should create a new step associated to the story" do
        @story.steps.should_receive(:new).with(:story_ids => ["1"])
        get :new, {:story_id => 1}
      end
    end

    context "is not associated to a story" do
      it "should create a new story" do
        Step.should_receive(:new)
        get :new
      end
    end
  end

  describe "GET, index" do
    it "should have a list of steps"
  end

  describe "POST, create" do
    it "should create a new step"

    context "valid step" do
      it "should save the step"
      it "should display a flash[:notice] message"
      it "should redirect to the step"
    end

    context "invalid step" do
      it "should not save the step"
      it "should render the new form"
    end
  end

  describe "GET, edit" do
    it "should find the step"
  end

  describe "PUT, update" do
    context "successfully  updates" do
      it "should update the step"
      it "should display a flash[:notice] message"
      it "should redirect to the step"
    end

    context "unsuccessfully  updates" do
      it "should display a flash[:error] message"
      it "should render the edit form"
    end
  end

  describe "DELETE, destroy" do
    it "should find the step"
    context "found step" do
      it "should destroy the step"
      it "should redirect to the steps path"
    end
  end

  describe "GET, sort" do
    it "should loop through each of the steps"
  end
end

