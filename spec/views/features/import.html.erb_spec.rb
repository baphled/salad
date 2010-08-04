require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/features/import.html.erb" do

  it "sends the import to the sync action" do
    assigns[:feature] = FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature").export
    render
    response.should have_selector :form, attribute = {:action => sync_features_path}
  end
end