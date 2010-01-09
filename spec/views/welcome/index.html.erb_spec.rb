require 'spec_helper'

describe "/welcome/index" do
  before(:each) do
    render 'welcome/index'
  end

  it "should display a message stating that there are no projects in Salad" do
    response.should have_tag('p', %r[There are no projects])
  end

  it "should display a link to the projects page" do
    response.should have_selector :div do |instructions|
      instructions.should contain 'Add a project'
    end
  end
end
