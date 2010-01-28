# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "common/_sortable_list.html.erb" do
  before(:each) do
    @projects = [mock_model(Project).as_new_record.as_null_object]
    render :partial => '/common/sortable_list', :locals => {:models => @projects,  :item_name => 'feature', :assoc => 'story', :order => false}
  end

  it "should have a list of items" do
    response.should have_selector :ul, attribute = {:id => 'features'}
  end

  context "it has a list of items" do
    it "should display a link to create a new item" do
      response.should have_selector :a do |content|
        content.should contain /^New /
      end
    it "should display the items name"
    end

    it "should display an icon set for each item"
    
  end
  
  context "it has no list of items" do
    it "should display a message stating there are no items present"
  end

  context "display a basic list" do
    it "should not display the order button"
  end

  context "display a sortable list" do
    it "should display the order button"
    it "should have a sorting handler"
    it "renders a sortable list"
  end
end

