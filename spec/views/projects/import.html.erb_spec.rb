require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/import.html.erb" do
  before(:each) do
    @project = stub_model(Project).as_null_object
    @project.location = "#{RAILS_ROOT}"
    assigns[:feature] = mock_model(Feature).as_null_object
    assigns[:imported] = @project.import_features
  end
  
  describe "viewing the import form" do
    context "invalid feature" do
      before(:each) do
        assigns[:imported] = @project.import_features
      end

      context "disabling submit if" do
        it "should has an invalid title" do
          assigns[:imported].first[:feature].title = nil
          render
          response.should have_selector :p, attribute = {:id => 'error'} do |content|
            content.should contain "Invalid feature"
          end
        end

        it "should has an invalid in order" do
          assigns[:imported].first[:feature].in_order = nil
          render
          response.should have_selector :p, attribute = {:id => 'error'} do |content|
            content.should contain "Invalid feature"
          end
        end
        
        it "should has an invalid as a" do
          assigns[:imported].first[:feature].as_a = nil
          render
          response.should have_selector :p, attribute = {:id => 'error'} do |content|
            content.should contain "Invalid feature"
          end
        end
        
        it "should has an invalid i want" do
          assigns[:imported].first[:feature].i_want = nil
          render
          response.should have_selector :p, attribute = {:id => 'error'} do |content|
            content.should contain "Invalid feature"
          end
        end

        context "when a feature file has a local duplicate" do
          before(:each) do
            @project.stub!(:location).and_return "#{RAILS_ROOT}/spec/fixtures"
          end

          it "should display the location of the duplicate file" do
            pending 'Need to implement functionality'
            render
            response.should have_selector :p, attribute = {:id => 'error'} do |content|
              content.should contain "Feature already exists in features/sample_one.feature"
            end
          end
        end

        it "should not have an import button" do
          assigns[:imported].first[:feature].i_want = nil
          render
          response.should_not have_selector :input, attribute = {:value => "Import failing feature"}
        end
      end
    end

    context "valid feature" do
      before(:each) do
        render
      end
      it "should diplay a list of feature files" do
        assigns[:imported].each do |feature|
          response.should contain "#{feature[:file]}".sub(/\.feature/,"").gsub(/_/," ")
        end
      end

      it "should diplay a list of feature files which contain feature text" do
        assigns[:imported].each do |file|
          response.should contain "#{file[:feature].title}"
        end
      end

      it "should trim from 'Feature:' feature line" do
          response.should_not =~ "Feature: "
      end

      it "should display a list of feature files which contain the feature 'In order' text" do
          response.should contain "In order"
      end

      it "should display a list of feature files which contain the feature 'As a' text" do
          response.should contain "As a"
      end

      it "should display a list of feature files which contain the feature 'I want' text" do
          response.should contain "I want"
      end

      it "should should have a form to submit our features" do
        response.should have_selector :form
      end

      it "should have a hidden field with the feature title for all features" do
        response.should have_selector :form do |content|
          content.should have_selector :input, attribute = {:type => "hidden"}
        end
      end

      it "should have a steps contain for each scenario" do
        response.should have_selector :ul , attribute = {:class => "steps"}
      end

      it "should display a 'Given' step" do
        response.should have_selector :ul, attribute = {:class => "steps"} do |step|
          step.should contain "Given"
        end
      end

      it "should display a 'When' step" do
        response.should have_selector :ul, attribute = {:class => "steps"} do |step|
          step.should contain "When"
        end
      end

      it "should display a 'Then' step" do
          response.should have_selector :ul, attribute = {:class => "steps"} do |step|
            step.should contain "Then"
          end
      end

      it "should highlight a step if it is already part of the system" do
        step = stub_model(Step, :title => 'Given I can view the projects page')
        response.should have_selector :b, :content => "#{step.title}"
      end
      
      context "A scenario has examples" do
        it "should display the examples" do
          response.should have_selector :td, :content => 'Examples'
        end
        
        it "should display the examples actions" do
          response.should have_selector :table do |table|
            table.should have_selector :td, :content => 'action'
          end
        end
        it "should display each of the actions items" do
          response.should have_selector :table do |table|
            table.should have_selector :td, :content => 'features'
          end
        end
        
      end
    end
  end

  describe "when a feature has already been added" do
    before(:each) do
      Feature.stub!(:find_by_title).
              with("We need to a way to store our stories within a project, this will help organise our stories.").
              and_return true
      render
    end
    it "should not display a feature for form is the feature already exists" do
      response.should_not have_selector :div, attribute = {:id => "feature_project"}
    end  
  end
end