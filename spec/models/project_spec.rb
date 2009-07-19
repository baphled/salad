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
end