class StoriesController < ApplicationController
  def index
    @stories = Story.find :all
    respond_to do |format|
      format.html
    end
  end
end