class WelcomeController < ApplicationController
  def index
    @project = Project.last
  end

end
