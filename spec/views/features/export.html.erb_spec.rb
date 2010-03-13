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
  end
end