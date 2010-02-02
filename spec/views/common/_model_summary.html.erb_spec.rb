# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/common/_model_summary.html.erb" do

  before(:each) do
    @date = Time.now
    @project = Project.first
  end
  describe "a project summary" do

    context "when the project is new" do
      before(:each) do
        render :locals => {:model => @project, :assoc => :features}
      end

      it "should display the created at field" do
        response.should contain "#{@project.creation_date}"
      end

      it "should display the date the project was updated" do
        response.should_not contain "Updated at: #{@project.updated_date}"
      end
    end

    context "when the project is updated" do
      before(:each) do
        @project.update_attribute(:updated_at, @date.tomorrow)
        render :locals => {:model => @project, :assoc => :features}
      end

      it "should display the date the project was updated" do
        response.should contain "Updated date: #{@project.updated_date}"
      end
    end
  end
  
end