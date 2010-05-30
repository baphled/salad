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
    @resource = Resource.new(:name => 'baphled', :project_id => '50164')
    @resource.tickets('feature').should_not be_empty
  end

  context "invalid resource" do
    before(:each) do
      @resource = Resource.new(:name => '', :project_id => '')
    end
    it "should have a project name" do
      @resource.save
      @resource.errors[:name].should eql "can't be blank"
    end

    it "should have a project id" do
      @resource.save
      @resource.errors[:project_id].should eql "can't be blank"
    end

    it "should have a valid project name" do
      @resource = Resource.new(:name => 'foo', :project_id => 23)
      @resource.save
      @resource.errors[:name].should eql "Must be a valid LightHouse project name"
    end

    it "should have a valid project id" do
      @resource = Resource.new(:name => 'baphled', :project_id => 23)
      @resource.save
      @resource.errors[:project_id].should eql "Must be a valid LightHouse project id"
    end
  end
end