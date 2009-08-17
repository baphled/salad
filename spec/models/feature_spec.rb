require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Feature do
  
  context "exporting features" do
    before(:each) do
      @feature = Feature.find 1
    end
    
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
      @feature.export.should contain "As a #{@feature.as_a}"
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
end