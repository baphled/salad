require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FeatureFile do
  before(:each) do
    @feature_file = FeatureFile.new("#{RAILS_ROOT}/spec/fixtures/projects.yml")
  end

  it "should be a child of the File object" do
    @feature_file.should be_a File
  end

  context "an invalid feature file" do
    it "should be invalid" do
      @feature_file.should be_invalid
    end
  end
  
  context "importing a feature file which contains scenario outlines" do
    before(:each) do
      @feature_file = FeatureFile.new "#{RAILS_ROOT}/features/plain/most_used.feature"
    end
    
    it "should store scenario outlines" do
      @feature_file.scenarios.first.scenario.should contain 'Users viewing an index page which is not projects should display a most used section'
    end
    
    it "should store the outlines steps" do
      @feature_file.scenarios.first.steps.should_not be_empty
    end
    
    it "should have a list of examples associated to it" do
      @feature_file.scenarios.first.examples.should_not be_empty
    end
    
    it "should have a list of associated actions" do
      @feature_file.scenarios.first.examples.first.actions.should_not be_empty
    end
    
    it "should story the actions in the expected format" do
      "items,action,state".split(',').each_with_index { |word,index| @feature_file.scenarios.last.examples.last.actions[index].title.should == word }
    end
    
    it "should store the actions items" do
      @feature_file.scenarios.last.examples.last.actions.last.items.should_not be_empty
    end
  end
  
  context "a valid feature file" do
    before(:each) do
      @feature_file = FeatureFile.new("#{RAILS_ROOT}/spec/fixtures/test.feature")
    end

    it "should be a cucumber feature file" do
      @feature_file.should_not be_invalid
    end

    it "should store the feature heading within the feature properties" do
      @feature_file.feature.should be_a String
    end

    it "should store the features in order heading" do
      @feature_file.in_order.should be_a String
    end

    it "should store the as a heading" do
      @feature_file.as_a.should_not be_nil
    end

    it "should store the features i want heading" do
      @feature_file.i_want.should_not be_nil
    end

    it "should store the scenario's for the feature" do
      @feature_file.scenarios.should_not be_nil
    end

    it "should contain a scenario" do
      @feature_file.scenarios.should_not be_nil
    end

    it "should contain a scenario with steps" do
      step = @feature_file.scenarios.first.steps.first
      step.title.should contain "Given I have my marbles"
    end

    it "should store the expected amount of steps" do
      @feature_file.scenarios.first.steps.count == 3
    end

    context "exporting the feature files information" do
      it "return the features title" do
        @feature_file.export.should be_a Feature
      end

      it "should return the in order property " do
        @feature_file.export.in_order.should_not be_nil
      end

      it "should return the as a property" do
        @feature_file.export.as_a.should be_a String
      end

      it "should return the i want property" do
        @feature_file.export.i_want.should be_a String
      end

      it "should return a list of stories" do
        @feature_file.export.stories.should_not be_empty
      end
    end
  end

  
end