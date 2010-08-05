require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/features/new.html.erb" do
  before(:each) do
    @projects = [stub_model(Project).as_null_object,stub_model(Project).as_null_object]
    Project.stub(:all).and_return @projects
  end

  context "filling in a new feature" do
    before(:each) do
      assigns[:feature] = Feature.new
      render
    end

    it "has a form" do
      response.should have_tag("form[action=#{features_path}][method=post]")
    end

    it "has a list of checkboxes for each project that is avaiable" do
      response.should have_selector :form do |content|
        @projects.each do |project|
          content.should have_selector :input, attribute = {:type => "checkbox", :value => "#{project.id}"}
        end
      end
    end

    it "has a 'In order' field " do
      have_tag("form[action=#{features_path}][method=post]") do
        with_tag('input#feature_in_order[name=?]', "feature[in_order]")
      end
    end

    # @TODO Change so that we use as instead of as_a
    it "has a 'As a' field " do
      have_tag("form[action=#{features_path}][method=post]") do
        with_tag('input#feature_as_a[name=?]', "feature[as_a]")
      end
    end

    it "has a 'I want' field " do
      have_tag("form[action=#{features_path}][method=post]") do
        with_tag('input#feature_i_want[name=?]', "feature[i_want]")
      end
    end
  end
end