require File.dirname(__FILE__) + '/../../spec_helper'

describe "/features/export.html.erb" do
  before(:each) do
    @feature = mock_model(Feature).as_new_record.as_null_object
    assigns[:feature] = @feature
    render
  end
  
  describe "GET, export" do
    it "should have display a title" do
      response.should contain "Exported feature:"
    end
    
    it "has a download link" do
      response.should have_selector :button, :contents => 'Download'
    end
  end
end