require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  before(:each) do
    @project = stub_model(Project).as_new_record.as_null_object
  end

  context "validation a location directory" do
    it "should have a validates_project_directory validation helper" do
      Project.respond_to?(:directory_is_valid?).should be_true
    end
  end

  context "project location is invalid" do

    it "should be valid in it is blank" do
      @project.stub(:location).and_return nil
      @project.errors[:location].should be_nil
    end
    
    it "should should display an error message"
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
      @project.import_features.should_not contain "^\."
    end
    
    it "should not include .." do
      @project.import_features.should_not contain ".."
    end
    
    it "should not include step_definitions" do
      @project.import_features.should_not contain "step_definitions"
    end
    
    it "should not include support" do
      @project.import_features.should_not contain "support"
    end

    it "finds the projects feature file" do
      @project.import_features.should contain "projects.feature"
    end

    it "finds features within directories" do
      @project.import_features.should contain "hover_functionality.feature"
    end

    context "when displaying the features import data, it should" do
      it "have a feature text" do
        @project.import_features.last[:feature].title.should_not be_nil
      end

      it "have a features in order text" do
        @project.import_features.last[:feature].in_order.should_not be_nil
      end

      it "have a features as a text" do
        @project.import_features.first[:feature].as_a.should_not be_nil
      end

      it "have a features 'I want' text" do
        @project.import_features.last[:feature].i_want.should_not be_nil
      end

      it "have a features stories text" do
        @project.import_features.last[:feature].stories.first.scenario.should_not be_nil
      end
    end
  end
end