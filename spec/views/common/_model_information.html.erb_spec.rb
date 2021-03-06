require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/common/_model_information.html.erb" do
  
  describe "a newly created project" do
    before(:each) do
      @project = Project.first
    end
    
    context "basic project information" do
      before(:each) do
        render :locals => {:model => @project}
      end

      it "should have the projects title" do
        response.should have_selector :span, :content => @project.title
      end

      it "should have a description" do
        response.should have_selector :span, :content => @project.description
      end

      it "should have an aim" do
        response.should have_selector :span, :content => @project.aim
      end

      it "should have an location" do
        response.should have_selector :span, :content => @project.location
      end
    end

    context "has not location" do
      before(:each) do
        @project.update_attribute(:location, nil)
        render :locals => {:model => @project}
      end

      it "should not display the location if one is not set" do
        response.should_not contain "Location:"
      end
    end
  end
end

