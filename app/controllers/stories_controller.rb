class StoriesController < ApplicationController
  def new
    
  end
  
  def create
    @story = Story.new(params[:story])
    @story.save
    flash[:notice] = "Story: #{@story.title}, was created"
    redirect_to @story
  end
  
  def show
    
  end
end