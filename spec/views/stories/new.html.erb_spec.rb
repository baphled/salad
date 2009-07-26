require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/stories/new.html.erb" do
  before(:each) do
    render
  end
  
  it "should have a form" do
    response.should have_tag("form[action=#{stories_path}][method=post]") do
      with_tag('input#story_title[name=?]', "story[title]")
      with_tag('textarea#story_body[name=?]', "story[body]")
      with_tag('input#story_submit[name=?]', "commit")
    end
  end
  
end