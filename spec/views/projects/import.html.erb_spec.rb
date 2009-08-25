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
      response.should contain "#{file[:file]}".sub(/\.feature/,"").sub(/_/," ")
    end
  end
  
  it "should diplay a list of feature files which contain feature text" do
    assigns[:list].each do |file|
      response.should contain "#{file[:feature_line]}"
    end
  end
  
  it "should trim from 'Feature:' feature line" do
    assigns[:list].each do |file|
      response.should_not =~ "Feature: "
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
  
  it "should should have a form to submit our features" do
    response.should have_selector :form
  end
  
  it "should have a text field with the feature title for all features" do
    assigns[:list].each do |file|
      response.should have_selector :form do |content|
        content.should have_selector :textarea
      end      
    end
  end
  
  it "should have a steps contain for each scenario" do
    assigns[:list].each do |file|
      response.should contain "Scenario: "        
      response.should have_selector :ul , attribute = {:class => "steps"}
    end
  end
  
  it "should display a 'Given' step" do
    assigns[:list].each do |file|
      response.should contain "Scenario: "        
      response.should have_selector :ul, attribute = {:class => "steps"} do |step|
        step.should contain "Given"
      end
    end
  end
  
  it "should display a 'When' step" do
    assigns[:list].each do |file|
      response.should contain "Scenario: "        
      response.should have_selector :ul, attribute = {:class => "steps"} do |step|
        step.should contain "When"
      end
    end
  end
  
  it "should display a 'Then' step" do
    assigns[:list].each do |file|
      response.should contain "Scenario: "        
      response.should have_selector :ul, attribute = {:class => "steps"} do |step|
        step.should contain "Then"
      end
    end
  end
  
  it "should highlight a step if it is already part of the system" do
    response.should have_selector :b, :content => "#{Step.find(4).title}"
  end
end