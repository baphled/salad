require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/stories/index.html.erb" do
  context "has stories" do
    before(:each) do
      assigns[:tags] = Story.tag_counts
      assigns[:stories] = Story.paginate(:page => params[:page],:per_page => 10)
      render
    end
    
    it "should have a list" do
      response.should have_selector :div, attribute = {:class=>"stories",:id=>"lists"} do |content|
        content.should have_selector :ul do |list|
          list.should have_selector :li
        end
      end
    end
    
    it "should have a list of stories " do
      Story.all.each do |story|
        response.should have_selector :div, attribute = {:class=>"stories",:id=>"lists"} do |content|
          content.should contain "Scenario: #{story.scenario}"
        end
      end
    end
    
  end
  
end