require File.dirname(__FILE__) + '/../../spec_helper'

describe "/features/show.html.erb" do

  before(:each) do
    @feature = mock_model(Feature, :title => 'story').as_null_object
  end

  describe "viewing feature" do
    before(:each) do
      @feature = Feature.make
      assigns[:feature] = @feature
      assigns[:feature_stories] = @feature.stories.paginate(:page=>1)
    end
    
    it "should have display the features informaion" do
      render
      response.should have_selector :div do |content|
        content.should contain @feature.title
      end
    end
    
    it "should have a list of stories associated to it" do
      render
      response.should have_selector :ul do |list|
        @feature.stories.each do |story|
          list.should have_selector :li do |content|
            content.should contain story.scenario
          end
        end
      end
    end


    it "has a link to view a feature file" do
      render
      response.should have_selector :a, attribute = {:href => source_feature_path(@feature)}
    end

    context "feature is exportable" do
      before(:each) do
        @feature.stub(:is_diff?).and_return true
        assigns[:feature] = @feature
        render
      end

      it "should display an export feature link" do
        pending "Need to setup so that the export link is visible"
        response.should have_selector :a, attribute = {:href=> export_feature_path(@feature) }
      end
    end
  end
  
  context "feature with no story" do
    before(:each) do
      @feature.stub!(:stories).and_return []
      assigns[:feature] = @feature
      render
    end
    
    it "should not display an export feature link" do
      response.should_not have_selector :a, attribute = {:href=> export_feature_path(@feature) }
    end
  end
  
  context "system feature that has changed" do
    before(:each) do
      @feature = mock_model(Feature,:title=>"A new feature").as_null_object
      @feature.stub!(:is_diff?).and_return true
      assigns[:feature] = @feature
      render
    end
    
    it "should display a view diff link" do
      response.should have_selector :a, attribute = {:href=> changes_feature_path(@feature) }
    end
    
    it "should display a patch link" do
      response.should have_selector :a, attribute = {:href=> feature_path(@feature, :format => :patch) }
    end
    
    it "should display a link to merge the source" do
      response.should have_selector :a, attribute = {:href=> merge_feature_path(@feature) }
    end
  end
  
  context "feature file has changed" do
    before(:each) do
      @feature.stub!(:is_diff?).and_return true
      assigns[:feature] = @feature
      render
    end
    
    it "should display the merge system link" do
      response.should have_selector :a, attribute = {:href=> system_merge_feature_path(@feature) }
    end
  end
end