require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/features/_legend.html.erb" do
  context "display for file changes" do
    before(:each) do
      render :locals => {:diff_for => "file"}
    end
    
    it "should have a legend displaying system changes as green" do
      response.should have_selector :div, attribute = {:id => "legend"} do |legend_wrapper|
        legend_wrapper.should have_selector :span, attribute = {:class => "gd"} do |content|
          content.should contain "Removing from file"
        end
      end
    end

    it "should have a legend displaying file changes as red" do
      response.should have_selector :div, attribute = {:id => "legend"} do |legend_wrapper|
        legend_wrapper.should have_selector :span, attribute = {:class => "gi"} do |content|
          content.should contain "Adding to file"
        end
      end
    end
  end
  
  context "display for system changes" do
    before(:each) do
      render :locals => {:diff_for => "system"}
    end
    
    it "should have a legend displaying system changes as green" do
      response.should have_selector :div, attribute = {:id => "legend"} do |legend_wrapper|
        legend_wrapper.should have_selector :span, attribute = {:class => "gi"} do |content|
          content.should contain "Adding to system"
        end
      end
    end

    it "should have a legend displaying file changes as red" do
      response.should have_selector :div, attribute = {:id => "legend"} do |legend_wrapper|
        legend_wrapper.should have_selector :span, attribute = {:class => "gd"} do |content|
          content.should contain "Removing from system"
        end
      end
    end
  end
end