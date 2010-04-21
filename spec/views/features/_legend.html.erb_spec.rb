require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/features/_legend.html.erb" do
  context "display for file changes" do
    before(:each) do
      render :locals => {:diff_from => "file", :diff_to => "file"}
    end
    
    it "should have a legend displaying system changes as green" do
      response.should have_selector :span, attribute = {:id => "legend"} do |legend_wrapper|
        legend_wrapper.should have_selector :span, attribute = {:class => "gd"} do |content|
          content.should contain "Removing from file"
        end
      end
    end

    it "should have a legend displaying file changes as red" do
      response.should have_selector :span, attribute = {:id => "legend"} do |legend_wrapper|
        legend_wrapper.should have_selector :span, attribute = {:class => "gi"} do |content|
          content.should contain "Adding to file"
        end
      end
    end
  end
  
  context "display for system changes" do
    before(:each) do
      render :locals => {:diff_from => "system", :diff_to => "system"}
    end
    
    it "should have a legend displaying system changes as green" do
      response.should have_selector :span, attribute = {:id => "legend"} do |legend_wrapper|
        legend_wrapper.should have_selector :span, attribute = {:class => "gi"} do |content|
          content.should contain "Adding to system"
        end
      end
    end

    it "should have a legend displaying file changes as red" do
      response.should have_selector :span, attribute = {:id => "legend"} do |legend_wrapper|
        legend_wrapper.should have_selector :span, attribute = {:class => "gd"} do |content|
          content.should contain "Removing from system"
        end
      end
    end
  end
  
  context "passing a change parameter" do
    before(:each) do
      render :locals => {:diff_from => "system", :diff_to => "file", :change => true}
    end
    it "should display a different copy for changes to the system" do
      response.should have_selector :span, attribute = {:id => "legend"} do |legend_wrapper|
        legend_wrapper.should have_selector :span, attribute = {:class => "gd"} do |content|
          content.should contain "Changes to the system"
        end
      end
    end
    
    it "should display a different copy for changes to the file" do
      response.should have_selector :span, attribute = {:id => "legend"} do |legend_wrapper|
        legend_wrapper.should have_selector :span, attribute = {:class => "gi"} do |content|
          content.should contain "Changes to the file"
        end
      end
    end
  end
end