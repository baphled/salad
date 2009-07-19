require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/index.html.erb" do

  context "No projects stored" do
    before(:each) do
      Project.stub!(:find).and_return []
      render
    end
    
    it "should display a message telling the user no projects are available" do
      response.should have_selector :span, :content => "No projects available"
    end
  end
end