# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/common/_model_summary.html.erb" do

  before(:each) do
    @date = Time.now
    @project = Project.first
  end
  describe "a project summary" do

    context "when the project is new" do
      before(:each) do
        render :locals => {:model => @project, :assoc => :features}
      end

      it "should display the created at field" do
        response.should contain "Creation date:"
      end

      it "should display the date the project was updated" do
        response.should_not contain "Updated date:"
      end
    end

    context "when the project is updated" do
      before(:each) do
        @project.update_attribute(:updated_at, @date.tomorrow)
        render :locals => {:model => @project, :assoc => :features}
      end

      it "should display the date the project was updated" do
        response.should contain "Updated date:"
      end
    end
    
    context "no associated features" do
      before(:each) do
        @project.update_attribute(:updated_at, @date.tomorrow)
        render :locals => {:model => @project, :assoc => :features}
      end
      
      it "should display the following message" do
        response.should contain "No features associated"
      end
      
      it "should not display the number of associated items as 0" do
        response.should_not contain "Total number of Features : 0"
      end
    end

    context "no associated stories" do
      before(:each) do
        @feature = mock_model(Feature).as_null_object
        @feature.stories.stub!(:count).and_return 0
        render :locals => {:model => @feature, :assoc => :stories}
      end
      
      it "should display the following message" do
        response.should contain "No stories associated"
      end
      
      it "should not display the number of associated items as 0" do
        response.should_not contain "Total number of Stories : 0"
      end
    end
  end
  
end