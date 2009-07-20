require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StoriesController do
  describe "POST, create" do
    before(:each) do
      @story = mock_model(Story,:title=>"A new story",:null_object=>true)
      Story.stub!(:new).and_return @story
      
    end
    context "the story is valid" do
      before(:each) do
        @story.stub!(:save).and_return true
      end
      it "should save the story" do
        @story.save.should eql true
        post :create
      end
      
    end
    
    context "the story is invalid" do
      before(:each) do
        @story.stub!(:title).and_return nil
        post :create
      end
      it "should not save if the title is not present" do
        @story.save.should_not eql true
      end
      
    end
  end
end