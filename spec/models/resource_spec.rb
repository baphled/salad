require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Resource do
  it "should have a resource name" do
    Resource.stub!(:name).and_return 'baphled'
    Resource.name.should eql 'baphled'
  end
  it "should have a project name or id" do
    Resource.stub!(:project).and_return '50164'
    Resource.project.should eql '50164'
  end
  
  it "should be able to make a call to lighthouse" do
    @resource = Resource.new(:name => 'baphled', :project => '50164')
    @resource.tickets('feature').should_not be_empty
  end

  context "invalid resource" do
    before(:each) do
      @resource = Resource.new(:name => '', :project => '')
    end
    it "should have a project name" do
      @resource.save
      @resource.errors[:name].should contain "can't be blank"
    end

    it "should have a project id" do
      @resource.save
      @resource.errors[:project].should contain "can't be blank"
    end

    it "should have a valid project name" do
      @resource = Resource.new(:name => 'foo', :project => 23)
      @resource.save
      @resource.errors[:name].should eql "must be a valid LightHouse project name"
    end

    it "should have a valid project" do
      @resource = Resource.new(:name => 'baphled', :project => 23)
      @resource.save
      @resource.errors[:project].should eql "must be a valid LightHouse project"
    end
  end
end