require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  before(:each) do
    @project = stub_model(Project).as_new_record.as_null_object
  end

  context "has invalid input" do
    before(:each) do
      @project.should_receive(:save).and_return false
    end
    
    it "should not save if project has no title" do
      @project.stub(:title).and_return nil  
      @project.save
    end
  end
  
  context "importing a projects features" do
    before(:each) do
      @project.location = "#{RAILS_ROOT}"
    end
    
    it "should not include ." do
      @project.import_features.should_not include "."
    end
    
    it "should not include .." do
      @project.import_features.should_not include ".."
    end
    
    it "should not include step_definitions" do
      @project.import_features.should_not include "step_definitions"
    end
    
    it "should not include support" do
      @project.import_features.should_not include "support"
    end

     context "when displaying the features import data, it should" do
      it "have a feature text" do
        @project.import_features.last[:feature].title.should contain "We need to be able to carry out searches on various parts of the application"
      end

      it "have a features in order text" do
        @project.import_features.last[:feature].in_order.should contain "to help find items in the application"
      end

      it "have a features as a text" do
        @project.import_features.last[:feature].as_a.should contain "user"
      end

      it "have a features 'I want' text" do
        @project.import_features.last[:feature].i_want.should contain "to be able to search for items within salad"
      end

      it "have a features stories text" do
        @project.import_features.last[:feature].stories.first.scenario.should contain "I need to be able to search for steps"
      end
    end
  end
end