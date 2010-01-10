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
      @project.find_features.should_not include "."
    end
    
    it "should not include .." do
      @project.find_features.should_not include ".."
    end
    
    it "should not include step_definitions" do
      @project.find_features.should_not include "step_definitions"
    end
    
    it "should not include support" do
      @project.find_features.should_not include "support"
    end
    
    it "should display a features feature text" do
      @project.find_features.should contain "We need to a way to store our stories within a project, this will help organise our stories."
    end
    
    it "should display a features in order text" do
      @project.find_features.should contain "In order to help manage and organise our projects"
    end
    
    it "should display a features as a text" do
      @project.find_features.should contain "As a user"
    end
    
    it "should display a features 'I want' text" do
      @project.find_features.should contain "I want"
    end
    
    it "should display a features stories text" do
      @project.find_features.should contain "Scenario: "
    end
  end
end