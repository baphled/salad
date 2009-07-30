require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/features/index.html.erb" do
  before(:each) do
    assigns[:features] = Feature.all
    render
  end
  
  context "has features" do    
    it "should have a list" do
      response.should have_selector :div do |content|
        content.should have_selector :ul do |list|
          list.should have_selector :li
        end
      end
    end
    
    it "should have a list of features " do
      Feature.all.each do |feature|
        response.should have_selector :div, attribute = {:class=>"features",:id=>"lists"} do |content|
          content.should contain feature.title
          content.should contain feature.body
        end
      end
    end
    
  end
  
  context "feature with stories associated to it" do
    it "should have a view stories link" do
      response.should have_selector :a, attribute = {:href=>"/features/1/stories"}
    end
  end
end