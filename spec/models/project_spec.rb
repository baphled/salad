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
  end
end