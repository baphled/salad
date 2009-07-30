class StoriesController < ApplicationController
  def new
    @story = Story.new
    respond_to do |format|
      format.html
    end
  end
  
  def index
    @stories = Story.find :all
    respond_to do |format|
      format.html
    end
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
    @story = Story.find params[:id]
  end
end