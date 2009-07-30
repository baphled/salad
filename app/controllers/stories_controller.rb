class StoriesController < ApplicationController
  def new
    @feature = Feature.find(params[:feature_id]) unless params[:feature_id].nil?
    if @feature
      @story = @feature.stories.new(:feature_ids => [params[:feature_id]])
    else
      @story = Story.new
    end
    
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