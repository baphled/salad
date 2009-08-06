require File.dirname(__FILE__) + '/../../spec_helper'

describe "/features/show.html.erb" do
  describe "viewing feature" do
    before(:each) do
      @feature = Feature.find 1
      assigns[:feature] = @feature
      render
    end
    
    it "should have display the features informaion" do
      response.should have_selector :div, attribute = {:id=>"feature_info"} do |content|
        content.should contain @feature.title
      end
    end
    
    it "should have a list of stories associated to it" do
      response.should have_selector :ul do |list|
        @feature.stories.each do |story|
          list.should have_selector :li do |content|
            content.should contain story.title
            content.should contain story.scenario
          end
        end
      end
    end
    
  end
end