require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FeatureFile do
  before(:each) do
    @feature_file = FeatureFile.new("#{RAILS_ROOT}/spec/blueprints.rb")
  end

  it "extends the File object" do
    @feature_file.should be_a File
  end

  context "invalid feature file" do
    it "should be invalid" do
      @feature_file.should be_invalid
    end
  end
  
  context "valid feature file with scenario outlines" do
    before(:each) do
      @feature_file = FeatureFile.new "#{RAILS_ROOT}/features/plain/enhancements.feature"
    end
    
    it "stores scenario outlines" do
      @feature_file.scenarios.first.scenario.should contain 'When a user visits the site without JS enable we want to display a header notifying them that the site works best with JS'
    end
    
    it "stores the outlines steps" do
      @feature_file.scenarios.first.steps.should_not be_empty
    end
    
    it "has a list of examples associated to it" do
      @feature_file.scenarios.first.example.should_not be_blank
    end
    
    it "has a list of associated actions" do
      @feature_file.scenarios.first.example.actions.should_not be_empty
    end
    
    it "the actions should be in the expected format" do
      @feature_file.scenarios.last.example.actions.first.title.should == 'page'
    end
    
    it "stores the actions items" do
      @feature_file.scenarios.last.example.actions.last.items.should_not be_empty
    end
  end
  
  context "valid feature file" do
    before(:each) do
      @feature_file = FeatureFile.new("#{RAILS_ROOT}/spec/fixtures/test.feature")
    end

    it "has a feature that is a string" do
      @feature_file.feature.should be_a String
    end

    it "has the in order value as a string" do
      @feature_file.in_order.should be_a String
    end

    it "stores the as a heading" do
      @feature_file.as_a.should_not be_nil
    end

    it "stores the features i want heading" do
      @feature_file.i_want.should_not be_nil
    end

    it "stores the scenario's for the feature" do
      @feature_file.scenarios.should_not be_nil
    end

    it "contains a scenario" do
      @feature_file.scenarios.should_not be_nil
    end

    it "contains a scenario with steps" do
      @feature_file.scenarios.first.steps.should_not be_nil
    end

    it "stores the expected amount of steps" do
      @feature_file.scenarios.first.steps.count == 3
    end

    it "has access to the files path" do
      @feature_file.path.should eql "#{RAILS_ROOT}/spec/fixtures/test.feature"
    end
    
    context "exporting the feature files information" do
      it "returns the features title" do
        @feature_file.export.should be_a Feature
      end

      it "has a in order property" do
        @feature_file.export.in_order.should_not be_nil
      end

      it "has a as a property" do
        @feature_file.export.as_a.should be_a String
      end

      it "has a i want property" do
        @feature_file.export.i_want.should be_a String
      end

      it "has a list of stories" do
        @feature_file.export.stories.should_not be_empty
      end
    end
  end

  
end