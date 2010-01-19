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

      it "should return the i want property" do
        @feature_file.export.i_want.should be_a String
      end

      it "should return a list of stories" do
        @feature_file.export.stories.should_not be_empty
      end
    end
  end

  
end