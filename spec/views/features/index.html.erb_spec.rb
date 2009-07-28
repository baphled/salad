require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/features/index.html.erb" do
  context "has features" do
    before(:each) do
      assigns[:features] = Feature.all
      render
    end
    
    it "should have a list" do
      response.should have_selector :div do |content|
        content.should have_selector :ul do |list|
          list.should have_selector :li
        end
      end
    end
    
    it "should have a list of features " do
      Feature.all.each do |feature|
        response.should have_selector :div, attribute = {:class=>"feature"} do |content|
          content.should contain feature.title
          content.should contain feature.body
        end
      end
    end
    
  end
  
end