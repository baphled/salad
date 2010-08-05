# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "common/_sortable_list.html.erb" do
  
  context "it has no list of items" do
    it "should display a message stating there are no items present" do
      render :partial => '/common/sortable_list', :locals => {:models => "",  :item_name => 'feature', :assoc => 'story', :order => false}
      response.should contain "No features present"
    end
  end

  context "a list with no items" do
    before(:each) do
      render :partial => '/common/sortable_list', :locals => {:models => "",  :item_name => 'feature', :assoc => 'story', :order => false}
    end
    
    it "has a list of items" do
      response.should have_selector :ul, attribute = {:id => 'features'}
    end

    it "displays a link to create a new item" do
      response.should have_selector :a do |content|
        content.should contain /^New Feature/
      end
    end
    
    it "does not display the order button" do
      response.should_not have_selector :span, attribute = {:id => 'order_icon'}
    end

    it "does not display any of the items handler elements" do
      response.should_not have_selector :span, attribute = {:class => 'handler ui-widget ui-widget-content ui-corner-all'}
    end
  end

  context "invalid locals" do
    it "invalid model" do
      render :partial => '/common/sortable_list', :locals => {:item_name => 'feature', :assoc => 'story', :order => false}
      response.should have_selector :span, attribute = {:id => 'error'} do |content|
        content.should contain "Experiencing problems with displaying the view"
      end
    end

    it "does not have a item_name" do
      render :partial => '/common/sortable_list', :locals => {:models => '', :assoc => 'story', :order => false}
      response.should have_selector :span, attribute = {:id => 'error'} do |content|
        content.should contain "Experiencing problems with displaying the view"
      end
    end

    it "has an invalid assoc" do
      render :partial => '/common/sortable_list', :locals => {:models => '', :item_name => 'feature', :order => false}
      response.should have_selector :span, attribute = {:id => 'error'} do |content|
        content.should contain "Experiencing problems with displaying the view"
      end
    end
  end

  describe "list has items" do
    before(:each) do
      @projects = [mock_model(Project).as_new_record.as_null_object]
      @projects.stub(:total_pages).and_return 1
    end


    context "displaying an unsortable list" do
      before(:each) do
        render :partial => '/common/sortable_list', :locals => {:models => @projects,  :item_name => 'project', :assoc => 'story', :order => false}
      end

      it "does not display the order button" do
        response.should_not have_selector :span, attribute = {:id => 'order_icon'}
      end

      it "displays an icon set for each item" do
        response.should have_selector :ul do |list_item|
          list_item.should have_selector :li, attribute = {:class => 'project'} do |content|
            content.should have_selector :span, attribute = {:class => 'icons ui-widget ui-widget-content ui-corner-all'}
          end
        end
      end

      it "does not display any of the items handlers" do
        response.should_not have_selector :span, attribute = {:class => 'handler ui-widget ui-widget-content ui-corner-all'}
      end
    end

    context "displaying a sortable list" do
      before(:each) do
        render :partial => '/common/sortable_list', :locals => {:models => @projects,  :item_name => 'feature', :assoc => 'story', :order => true}
      end

      it "displays items handler elements" do
        response.should have_selector :span, attribute = {:class => 'handler ui-widget ui-widget-content ui-corner-all'}
      end
      
      it "renders a sortable list" do
        response.should have_selector :ul, attribute = {:id => 'features'} do |list|
          list.should have_selector :li
        end
      end
    end
  end

  context "a projects with a valid feature file" do
    before(:each) do
      @features = [mock_model(Feature,:path => "#{RAILS_ROOT}/features/tag_cloud.feature").as_null_object]
      @features.stub(:total_pages).and_return 1
      render :partial => '/common/sortable_list', :locals => {:models => @features, :item_name => 'feature', :assoc => 'story', :order => true}
    end
    
    it "displays the path location" do
      response.should contain "view source file"
    end
  end
end