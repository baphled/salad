require File.dirname(__FILE__) + '/../../spec_helper'

describe "/features/export.html.erb" do
  before(:each) do
    @feature = Feature.make
    assigns[:feature] = @feature
    render
  end
  
  describe "GET, export" do
    it "displays a title" do
      response.should contain "Exported feature:"
    end
    
    it "has a download button" do
      response.should have_selector :button do |content|
        content.should contain 'Download'
      end
    end
  end
end