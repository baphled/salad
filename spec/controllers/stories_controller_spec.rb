require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StoriesController do
  describe "POST, create" do
    
    context "the story is valid"
      before(:each) do
        @story = mock_model(Story,:title=>"A new story")
        Story.stub!(:new).and_return @story
        @story.should_receive :save
      end
      it "should save the story" do
        
        post :create
      end
      
  end
end