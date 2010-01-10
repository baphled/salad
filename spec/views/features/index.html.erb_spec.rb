require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/features/index.html.erb" do
  before(:each) do
    assigns[:tags] = []
    assigns[:features] = [stub_model(Feature,:title => 'nu', :created_at => Time.now).as_null_object,
                          stub_model(Feature,:title => 'suttin else', :created_at => Time.now).as_null_object]
    render
  end
  
  describe "a list of features" do
    it "should display the features creation date" do
      assigns[:features].each do |feature|
        response.should contain "Created at: #{feature.creation_date}"
      end
    end
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
      assigns[:features].each do |feature|
        response.should have_selector :div do |content|
          content.should contain feature.title
        end
      end
    end
    
  end
  
  context "feature with stories associated to it" do
    it "should have a view stories link" do
      response.should have_selector :a, attribute = {:href=> feature_path(assigns[:features].first)}
    end
  end
end