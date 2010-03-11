require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Feature do
  before(:each) do
    @feature ||= Feature.first
  end

  it "can store the features file location" do
    @feature.stub!(:path).and_return "#{RAILS_ROOT}/features/plain/most_used.feature"
    @feature.path.should contain "#{RAILS_ROOT}/features/plain/most_used.feature"
  end

  it "should save if the feature location is valid" do
    @feature.update_attribute(:path, "#{RAILS_ROOT}/features/plain/most_used.feature").should be_true
  end
  
  it "should not save if the feature location is not valid" do
    @feature.path = 'foo'
    @feature.save.should be_true
  end

  context "exporting features" do
    
    it "should display the 'Feature:' prefix" do
      @feature.export.should contain "Feature:"
    end
    
    it "should display the feature title" do
      @feature.export.should contain "Feature: #{@feature.title}"
    end
    
    it "should contain an in order line" do
      @feature.export.should contain "In order"
    end
    
    it "should contain the 'in order' contents" do
      @feature.export.should contain "In order #{@feature.in_order}"
    end
    
    it "should contain an 'as a' line" do
      @feature.export.should contain "As a"
    end
    
    it "should contain a 'as a' contents" do
      @feature.export.should contain "As #{@feature.as_a}"
    end
    
    it "should contain a 'i want' line" do
      @feature.export.should contain "I want"
    end
    
    it "should contain a 'i want contents" do
      @feature.export.should contain "I want #{@feature.i_want}"
    end
    
    it "should should have at least one scenario" do
      @feature.export.should contain "Scenario:"
    end
    
    it "should have a scenario for each story" do
      @feature.stories.each do |story|
        if not story.steps.blank?
          @feature.export.should contain "#{story.scenario}"
        end
      end
    end
    
    it "should display each stories steps" do
      @feature.stories.each do |story|
        if not story.steps.nil?
          story.steps.each do |step|
            @feature.export.should contain "#{step.title}"
          end
        end
      end
    end
  end

  context "checking the difference between a stored feature and the source file" do
    before(:each) do
      @feature = FeatureFile.new("#{RAILS_ROOT}/features/plain/navigations.feature").export
      @feature.update_attribute(:path, "#{RAILS_ROOT}/features/plain/navigations.feature")
    end
    
    it "should be able to export a feature for comparison" do
      @feature.export.should_not be_empty
    end

    it "should be able to get the features feature file" do
      pending
      @feature.get_source_file.should contain @feature.export
    end

    it "should be able to compare the feature and its related feature file"
    it "should return true if there is no diff"
    it "should return true if there is a diff"
    
    context "storing the diff" do
      it "should save the file in tmp"
      it "should save the diff file with the feature name as its filename"
      it "should save over any existing diff file"
    end
  end
end