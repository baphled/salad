require File.dirname(__FILE__) + '/../../spec_helper'

describe "/features/file.html.erb" do
  before(:each) do
    @file = File.read("#{RAILS_ROOT}/features/plain/tag_cloud.feature")
    assigns[:file] = @file
  end
  
  it "should display the original feature files contents" do
    render
    response.should contain "Feature: Viewing an items tags"
  end
end