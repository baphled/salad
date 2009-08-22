require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/import.html.erb" do
  before(:each) do
    @project =Project.find(1)
    @project.location = "#{RAILS_ROOT}"
    assigns[:list] = @project.find_features
    render
  end
  
  it "should diplay a list of feature files" do
    assigns[:list].each do |file|
      response.should contain "#{file[:file]}"
    end
  end
  
  it "should diplay a list of feature files which contain feature text" do
    assigns[:list].each do |file|
      response.should contain "#{file[:feature_line]}"
    end
  end
  
  it "should trim from 'Feature:' feature line" do
    assigns[:list].each do |file|
      response.should_not contain "Feature: "
    end
  end
  
  it "should display a list of feature files which contain the feature 'In order' text" do
    assigns[:list].each do |file|
      response.should contain "In order"
    end
  end
  
  it "should display a list of feature files which contain the feature 'As a' text" do
    assigns[:list].each do |file|
      response.should contain "As a"
    end
  end
  
  it "should display a list of feature files which contain the feature 'I want' text" do
    assigns[:list].each do |file|
      response.should contain "I want"
    end
  end
  
  it "should display a list of feature files which contain the feature stories" do
    assigns[:list].each do |file|
      response.should contain "Scenario: "
    end
  end
  
end