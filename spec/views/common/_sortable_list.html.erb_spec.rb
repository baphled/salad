# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "common/_sortable_list.html.erb" do
  before(:each) do
    @projects = [mock_model(Project).as_new_record.as_null_object]
    
  end
  
  context "it has no list of items" do
    it "should display a message stating there are no items present"
  end

  context "display a basic list" do
    before(:each) do
      render :partial => '/common/sortable_list', :locals => {:models => "",  :item_name => 'feature', :assoc => 'story', :order => false}
    end
    
    it "should have a list of items" do
      response.should have_selector :ul, attribute = {:id => 'features'}
    end

    it "should display a link to create a new item" do
      response.should have_selector :a do |content|
        content.should contain /^New Feature/
      end
    end
    
    it "should not display the order button"
  end

  context "it has a list of items" do
    before(:each) do
      render :partial => '/common/sortable_list', :locals => {:models => Project.all,  :item_name => 'feature', :assoc => 'story', :order => false}
    end
    it "should display an icon set for each item" do
      response.should have_selector :ul do |list_item|
        list_item.should have_selector :li, attribute = {:class => 'project'} do |content|
          content.should have_selector :span, attribute = {:class => 'icons'}
        end
      end
    end
    
  end
  

  context "display a sortable list" do
    it "should display the order button"
    it "should have a sorting handler"
    it "renders a sortable list"
  end
end