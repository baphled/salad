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
      @feature.export.should contain "\tIn order"
    end
    
    it "should contain the 'in order' contents" do
      @feature.export.should contain "\tIn order #{@feature.in_order}"
    end
    
    it "should contain an 'as a' line" do
      @feature.export.should contain "\tAs a"
    end
    
    it "should contain a 'as a' contents" do
      @feature.export.should contain "\tAs a #{@feature.as_a}"
    end
    
    it "should contain a 'i want' line" do
      @feature.export.should contain "\tI want"
    end
    
    it "should contain a 'i want contents" do
      @feature.export.should contain "\tI want #{@feature.i_want}"
    end
  end
end