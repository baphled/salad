class StoriesController < ApplicationController
  def new
    @story = Story.new
  end
  
  def create
    @story = Story.new(params[:story])
    respond_to do |format|
      if @story.save
        flash[:notice] = "Story: #{@story.title}, was created"
        format.html { redirect_to @story }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def show
    
  end
end