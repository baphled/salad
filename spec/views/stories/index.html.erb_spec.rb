require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/stories/index.html.erb" do
  before(:each) do
    assigns[:tags] = []
  end

  context "there are no stories" do
    before(:each) do
      @stories = []
      Story.stub(:paginate).with(:page => params[:page],:per_page => 5).and_return @stories
      render
    end

    it "should display a message stating there are no stories" do
      response.should contain "No stories present"
    end
  end

  context "has stories" do
    before(:each) do
      @stories = [mock_model(Story).as_null_object]
      assigns[:stories] = @stories
      assigns[:stories].stub(:total_pages).and_return 1
      render 
    end
    
    it "should have a list" do
      response.should have_selector :div, attribute = {:id=>"lists"} do |content|
        content.should have_selector :ul do |list|
          list.should have_selector :li
        end
      end
    end
    
    it "should have a list of stories " do
      @stories.each do |story|
        response.should have_selector :div, attribute = {:id=>"lists"} do |content|
          content.should contain "Scenario: #{story.scenario}"
        end
      end
    end
    
  end
  
end