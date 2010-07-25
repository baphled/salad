require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  before(:each) do
    @project = stub_model(Project).as_new_record.as_null_object
  end

  context "validation a location directory" do
    it "should have a validates_project_directory validation helper" do
      @project.respond_to?(:directory_is_valid?).should be_true
    end
  end

  context "project location is invalid" do

    it "should not be validated if it is blank" do
      @project.stub(:location).and_return nil
      @project.save
      @project.errors[:location].should be_nil
    end
    
    it "should display an error message if given a path" do
      @project.stub(:location).and_return "/blah/"
      @project.save
      @project.errors[:location].should_not be_nil
    end
  end
  
  context "has invalid input" do
    before(:each) do
      @project.should_receive(:save).and_return false
    end

    #todo make sure save is actually false
    it "should not save if project has no title" do
      @project.stub(:title).and_return nil  
      @project.save
    end
  end
  
  context "importing a projects features" do
    before(:each) do
      @project.location = "#{RAILS_ROOT}"
      file = "#{RAILS_ROOT}/features/plain/projects.feature"
      result = [{:file => file, :feature => mock_model(Feature).as_null_object}]
      @project.stub!(:import_features).and_return result
      @file = @project.import_features
    end
    
    it "should not include ." do
      @file.first[:file].should_not contain "^\."
    end
    
    it "should not include .." do
      @file.first[:file].should_not contain ".."
    end
    
    it "should not include step_definitions" do
      @file.first[:file].should_not contain "step_definitions"
    end
    
    it "should not include support" do
      @file.first[:file].should_not contain "support"
    end

    it "finds the projects feature file" do
      @file.first[:file].should contain "projects.feature"
    end

    context "when displaying the features import data, it should" do
      it "have a feature text" do
        @file.first[:feature].title.should_not be_nil
      end

      it "have a features in order text" do
        @file.first[:feature].in_order.should_not be_nil
      end

      it "have a features as a text" do
        @file.first[:feature].as_a.should_not be_nil
      end

      it "have a features 'I want' text" do
        @file.first[:feature].i_want.should_not be_nil
      end

      it "have a features stories text" do
        @file.first[:feature].stories.first.scenario.should_not be_nil
      end
      
    end
    
    
  end

  context "listing importable features" do
    before(:each) do
      @project = Project.make
    end
    
    context "with importable features" do
      before(:each) do
        file = "#{RAILS_ROOT}/features/plain/projects.feature"
        result = [{:file => file, :feature => mock_model(Feature).as_null_object}]
        @project.stub!(:import_features).and_return result
      end
      
      it "gets the features to import" do
        @project.should_receive(:import_features)
        @project.features_to_import?
      end
      
      it "searches for each feature on the system" do
        Feature.should_receive(:find_by_path)
        @project.features_to_import?
      end

      it "returns true if there are importable features" do
        @project.should have_features_to_import
      end
    end
    
    context "with no importable features" do
      before(:each) do
        @project.stub!(:import_features).and_return []
      end
      
      it "returns false if there are no importable features" do
        @project.features_to_import?.should be_false
      end
          
    end
  end
end