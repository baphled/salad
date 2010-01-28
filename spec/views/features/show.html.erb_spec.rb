require File.dirname(__FILE__) + '/../../spec_helper'

describe "/features/show.html.erb" do

  before(:each) do
    @feature = stub_model(Feature, :title => 'story').as_null_object
  end

  describe "viewing feature" do
    before(:each) do
      @feature = Feature.first
      assigns[:feature] = @feature
      render :locals => {
                    :models => @feature.stories.paginate(
                      :page=>1,
                      :per_page=>10,
                      :order=>"feature_stories.position"),
                    :item_name => 'story',
                    :order =>true}
    end
    
    it "should have display the features informaion" do
      response.should have_selector :div, attribute = {:class=>"info"} do |content|
        content.should contain @feature.title
      end
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
      response.should have_selector :a, attribute = {:href=> feature_export_path(@feature) }
    end
    
  end
  
  describe "feature with no story" do
    before(:each) do
      @feature.stub!(:stories).and_return []
      assigns[:feature] = @feature
      render
    end
    
    it "should not display an export feature link" do
      response.should_not have_selector :a, attribute = {:href=> feature_export_path(@feature) }
    end
  end
end