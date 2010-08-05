require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "projects/new.html.erb" do
  before(:each) do 
    @features = []
    3.times { |project_number| @features << mock_model(Feature, :title => "Feature number #{project_number}").as_null_object }
    Feature.stub(:all).and_return @features
    assigns[:project] = stub_model(Project).as_new_record
    render
  end

  it "displays a form" do
    response.should have_selector :form, attribute = {:action => projects_path}
  end

  context "each available project" do
    it "has a checkbox" do
      response.should have_selector :form do |content|
        @features.each do |feature|
          content.should have_selector :input, attribute = {:type => "checkbox", :value => "#{feature.id}"}
        end
      end
    end
  end
  
  it "has a 'location' field " do
    have_tag("form[action=#{projects_path}][method=post]") do
      with_tag('input#project_location[name=?]', "project[location]")
    end
  end
end