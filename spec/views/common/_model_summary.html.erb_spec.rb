# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/common/_model_summary.html.erb" do

  context "displaying a newly created projects summary" do
    before(:each) do
      @date = Time.now
      @project = mock_model(Project,
                              :title => 'A project',
                              :description => 'A description',
                              :aim => 'An aim',
                              :created_at => @date).as_null_object
      render :locals => {:model => @project, :assoc => :features}
    end

    it "should display the created at field" do
      response.should contain "#{@project.creation_date}"
    end

    it "should display the date the project was updated" do
      response.should_not contain "Updated at: #{@project.updated_date}"
    end
  end
  
end