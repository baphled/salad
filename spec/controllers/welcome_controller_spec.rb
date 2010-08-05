require 'spec_helper'

describe WelcomeController do

  describe "GET 'index'" do
    it "makes a successful request" do
      get 'index'
      response.should be_success
    end
  end
end
