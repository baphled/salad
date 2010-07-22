require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Feature do
  before(:each) do
    steps = []
    3.times { |i| steps << Step.make }
    @feature ||= Feature.make(:stories => [Story.make(:steps => steps)])
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
    @feature.save.should_not be_true
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
    
    it "should contain an 'as' line" do
      @feature.export.should contain "As"
    end
    
    it "should contain a 'as' contents" do
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
            @feature.export.should contain "#{step.title.sub(/Given|When|Then/, '')}"
          end
        end
      end
    end

    context "exporting a scenario with examples" do
      before(:each) do
        @feature = FeatureFile.new("#{RAILS_ROOT}/features/plain/navigations.feature").export
      end

      it "should display the example heading" do
        @feature.export.should contain "Examples: #{@feature.stories.first.example.heading}"
      end
      
      it "should display the examples action headings" do
        @feature.stories.first.example.actions.each do |action|
          @feature.export.should contain "| #{action.title} |"
        end
      end
      
      it "should have items" do
        @feature.stories.first.example.actions.each do |action|
          action.items.each do |item|
            if item.title == '&nbsp;'
              @feature.export.should contain "| |"
            else
              @feature.export.should contain "| #{item.title} |"
            end
          end
        end
      end
    end
    
  end

  context "checking the difference between a stored feature and the source file" do
    before(:each) do
      @feature = FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature").export
    end
    
    it "should be able to export a feature for comparison" do
      @feature.export.should_not be_empty
    end

    it "should store the system based feature in a temp file" do
      FileUtils.touch("#{RAILS_ROOT}/tmp/#{File.basename(@feature.path)}.tmp")
      file = File.new("#{RAILS_ROOT}/tmp/#{File.basename(@feature.path)}.tmp", 'w')
      file.write(@feature.export)
      file.should_not == ''
    end

    it "should return true if there is a diff" do
      @feature.update_attribute(:title, 'Something different')
      @feature.is_diff?.should be_true
    end

    it "should return false if there is no diff" do
      @feature.is_diff?.should be_false
    end
  end
  
  context "finding for features that have not been added to the system yet" do
    before(:each) do
      Feature.stub!(:imports_found).with("#{RAILS_ROOT}").and_return [FeatureFile.new("#{RAILS_ROOT}/spec/fixtures/features/tag_cloud.feature").export]
    end
    
    it "should return a list of files to import" do
      Feature.imports_found("#{RAILS_ROOT}").should_not be_empty
    end
    
    it "contains all valid feature paths" do
      Feature.imports_found("#{RAILS_ROOT}").each { |feature| File.exist?(feature.path).should be_true }
    end
  end

  describe "#sync" do
    before(:each) do
      content = "Feature: A different title\n  In order to view tags associated to a item\n  As a user\n  I want to be able to view them on each item index\n\n  Scenario: Displaying the projects tags cloud when there are associated tags available\n    Given there are \"project\" tags\n    And the \"project\" tags are not empty\n    When we visit the \"projects\" index\n    Then the tags cloud should be displayed\n\n  Scenario: Displaying the features tags cloud when there are associated tags available\n    Given there are \"feature\" tags\n    And the \"feature\" tags are not empty\n    When we visit the \"features\" index\n    Then the tags cloud should be displayed\n\n  Scenario: Displaying the stories tags cloud when there are associated tags available\n    Given there are \"story\" tags\n    And the \"story\" tags are not empty\n    When we visit the \"stories\" index\n    Then the tags cloud should be displayed\n\n  Scenario: Displaying the steps tags cloud when there are associated tags available\n    Given there are \"step\" tags\n    And the \"step\" tags are not empty\n    When we visit the \"steps\" index\n    Then the tags cloud should be displayed"
      @feature.stub!(:export).and_return content
      @feature.stub!(:path).and_return "#{RAILS_ROOT}/spec/fixtures/features/tag_cloud.feature"
    end
    
    context "patching a feature file in dry-run mode" do
      it "gets a patch of the changes" do
        @feature.should_receive(:patch)
        @feature.sync(true)
      end
            
      context "it successfully synchronises a feature file" do
        before(:each) do
          @feature.stub!(:sync).and_return true
        end

        it "should return true" do
          @feature.sync(true).should == true
        end
      end

      context "it unsuccessfully synchronises a feature file" do
        before(:each) do
          @feature.stub!(:sync).and_return false
        end

        it "should return false" do
          @feature.sync.should == false
        end
      end
    end

    context "patching a feature file" do
      it "should return true" do
        @feature.stub!(:sync).with(false).and_return true
        @feature.sync(false).should == true
      end
    
      it "should display false" do
        @feature.stub!(:sync).with(false).and_return false
        @feature.sync(false).should == false
      end
    end
  end
end