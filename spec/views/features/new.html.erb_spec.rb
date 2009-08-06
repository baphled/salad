require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/features/new.html.erb" do
  before(:each) do
    @projects = Project.find :all
    assigns[:feature] = Feature.new
    assigns[:projects] = @projects
    render
  end
  
  it "should have a form" do
    response.should have_tag("form[action=#{features_path}][method=post]") do
      with_tag('input#feature_title[name=?]', "feature[title]")
      with_tag('textarea#feature_body[name=?]', "feature[body]")
      with_tag('input#feature_submit[name=?]', "commit")
    end
  end
  
  it "should have a list of checkboxes for each project that is avaiable" do
    response.should have_selector :form do |content|
      @projects.each do |project|
        content.should have_selector :input, attribute = {:type => "checkbox", :value => "#{project.id}"}
      end
    end
  end
  
  it "should have a 'In order' field " do
    have_tag("form[action=#{features_path}][method=post]") do
      with_tag('input#feature_in_order[name=?]', "feature[in_order]")
    end
  end
  
  it "should have a 'As a' field " do
    have_tag("form[action=#{features_path}][method=post]") do
      with_tag('input#feature_as_a[name=?]', "feature[as_a]")
    end
  end
end