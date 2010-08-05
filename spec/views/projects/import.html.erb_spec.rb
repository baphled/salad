require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/import.html.erb" do
  before(:each) do
    @project = stub_model(Project).as_null_object
    file = "#{RAILS_ROOT}/features/plain/projects.feature"
    feature ||= FeatureFile.new(file).export
    result ||= {:file => file, :feature => feature}
    @project.stub!(:import_features).and_return [result]
    
    assigns[:feature] = mock_model(Feature).as_null_object
    assigns[:imported] = @project.import_features
    assigns[:project] = @project
  end
  
  it "stores the current projects id for later use" do
    render
    response.should have_selector :input, attribute = {:type => "hidden", :id => 'current_project_id'}
  end

  context "viewing the import form" do

    it "sends the import to the sync action" do
      render
      response.should have_selector :form, attribute = {:action => sync_features_path}
    end

    context "with an invalid feature" do
      it "should has an invalid title" do
        assigns[:imported].first[:feature].title = nil
        render
        response.should have_selector :p, attribute = {:id => 'error'} do |content|
          content.should contain "Invalid feature"
        end
      end

      it "has an invalid in order" do
        assigns[:imported].first[:feature].in_order = nil
        render
        response.should have_selector :p, attribute = {:id => 'error'} do |content|
          content.should contain "Invalid feature"
        end
      end

      it "has an invalid as a" do
        assigns[:imported].first[:feature].as_a = nil
        render
        response.should have_selector :p, attribute = {:id => 'error'} do |content|
          content.should contain "Invalid feature"
        end
      end

      it "has an invalid i want" do
        assigns[:imported].first[:feature].i_want = nil
        render
        response.should have_selector :p, attribute = {:id => 'error'} do |content|
          content.should contain "Invalid feature"
        end
      end

      context "duplicate local features" do
        before(:each) do
          @project.stub!(:location).and_return "#{RAILS_ROOT}/spec/fixtures"
        end
      end

      it "does not have an import button" do
        assigns[:imported].first[:feature].i_want = nil
        render
        response.should_not have_selector :input, attribute = {:value => "Import failing feature"}
      end
    end
      
    context "with a valid features" do
      before(:each) do
        Step.create(:title => 'Given I can view the projects page')
        render
      end
      
      it "displays a list of feature files" do
        assigns[:imported].each do |feature|
          response.should contain "#{feature[:file]}".sub(/\.feature/,"").gsub(/_/," ")
        end
      end


      it "does not display 'Feature:'" do
        response.should_not =~ "Feature: "
      end

      describe "each" do
        # @TODO Refactor spec to make it more flexible
        it "contains a feature title" do
          assigns[:imported].each do |file|
            response.should contain "#{file[:feature].title}"
          end
        end

        it "contains 'In order'" do
          assigns[:imported].each do |file|
            response.should contain "In order"
          end
        end

        it "contains feature 'As a'" do
          assigns[:imported].each do |file|
            response.should contain "As a"
          end
        end

        it "contains 'I want'" do
          assigns[:imported].each do |file|
            response.should contain "I want"
          end
        end

        it "contains a hidden field with the title" do
          assigns[:imported].each do |file|
            response.should have_selector :input, attribute = {:type => "hidden", :value => file[:feature].title}
          end
        end
      end

      it "has a form" do
        response.should have_selector :form
      end

      # @TODO review
      it "has a steps for each scenario" do
        response.should have_selector :ul , attribute = {:class => "steps"}
      end

      it "displays 'Given' steps" do
        response.should have_selector :ul, attribute = {:class => "steps"} do |step|
          step.should contain "Given"
        end
      end

      it "displays 'When' steps" do
        response.should have_selector :ul, attribute = {:class => "steps"} do |step|
          step.should contain "When"
        end
      end

      it "displays 'Then' steps" do
        response.should have_selector :ul, attribute = {:class => "steps"} do |step|
          step.should contain "Then"
        end
      end
    end
    
    
    context "with scenarios containing examples" do
      before(:each) do
        file = "#{RAILS_ROOT}/features/plain/enhancements.feature"
        feature ||= FeatureFile.new(file).export
        result ||= {:file => file, :feature => feature}
        @project.stub!(:import_features).and_return [result]
        assigns[:imported] = @project.import_features
        render
      end
      
      it "displays the examples" do
        response.should have_selector :td, :content => 'Examples'
      end
      
      it "displays the examples actions" do
        response.should have_selector :table do |table|
          table.should have_selector :td, :content => 'page'
        end
      end
      
      it "displays each of the actions items" do
        response.should have_selector :table do |table|
          table.should have_selector :td, :content => 'features'
        end
      end
      
    end
  end

  context "feature has already been added" do
    before(:each) do
      Feature.stub!(:find_by_title).
              with("We need to a way to store our stories within a project, this will help organise our stories.").
              and_return true
      render
    end
    it "does not display a feature form" do
      response.should_not have_selector :form
    end  
  end
end