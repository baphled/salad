require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Resource do
  it "should have a resource name" do
    Resource.stub!(:name).and_return 'baphled'
    Resource.name.should eql 'baphled'
  end
  it "should have a project name or id"
end