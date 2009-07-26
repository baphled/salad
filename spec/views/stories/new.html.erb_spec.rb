require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/stories/new.html.erb" do
  before(:each) do
    @projects = Project.find :all
    assigns[:story] = Story.new
    assigns[:projects] = @projects
    render
  end
  
  it "should have a form" do
    response.should have_tag("form[action=#{stories_path}][method=post]") do
      with_tag('input#story_title[name=?]', "story[title]")
      with_tag('textarea#story_body[name=?]', "story[body]")
      with_tag('input#story_submit[name=?]', "commit")
    end
  end
  
  it "should have a list of checkboxes for each project that is avaiable" do
    response.should have_selector :form do |content|
      @projects.each do |project|
        content.should have_selector :input, attribute = {:type => "checkbox", :value => "#{project.id}"}
      end
    end
  end
end