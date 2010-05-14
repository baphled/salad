require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Resource do
  it "should have a resource name" do
    Resource.stub!(:name).and_return 'baphled'
    Resource.name.should eql 'baphled'
  end
  it "should have a project name or id" do
    Resource.stub!(:project_id).and_return '50164'
    Resource.project_id.should eql '50164'
  end
  
  it "should be able to make a call to lighthouse" do
    Resource.tickets('baphled', '50164', 'feature').should_not be_empty
  end
end