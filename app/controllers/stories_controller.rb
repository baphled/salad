class StoriesController < ApplicationController
  def new
    
  end
  
  def create
    @story = Story.new(params[:story])
    @story.save
    redirect_to @story
  end
  
  def show
    
  end
end