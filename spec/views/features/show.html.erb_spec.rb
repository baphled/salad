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
    
    it "should have a created date" do
      response.should contain "Created at: #{@feature.created_at}"
    end
    
    it "should have a list of stories associated to it" do
      response.should have_selector :ul do |list|
        @feature.stories.each do |story|
          list.should have_selector :li do |content|
            content.should contain story.scenario
          end
        end
      end
    end
    
    it "should display an export feature link" do
      response.should have_selector :a, attribute = {:href=>"/features/1/export"}
    end
    
  end
  
  describe "feature with no story" do
    before(:each) do
      @feature = Feature.find 2
      assigns[:feature] = @feature
      render
    end
    
    it "should not display an export feature link" do
      response.should_not have_selector :a, attribute = {:href=>"/features/2/export"}
    end
  end
end