require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  context "has invalid input" do
    before(:each) do
      @project = Project.new(:description=>"hey",:aim=>"our aim")
    end
    
    it "should not save if project has no title" do
      @project.save.should eql false
    end
  end
  
  context "importing a projects features" do
    before(:each) do
      @project = Project.find(1)
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
    
    it "should should display a features feature text" do
      @project.find_features.should contain "Feature: We need to a way to store our stories within a project, this will help organise our stories."
    end
  end
end