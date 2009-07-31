class StoriesController < ApplicationController
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
  
  def edit
    @story = Story.find params[:id]
  end
  
  def new
    if not params[:feature_id].nil?
      @feature = Feature.find(params[:feature_id])
      @story = @feature.stories.new(:feature_ids => [params[:feature_id]])
    else
      @story = Story.new
    end
    respond_to do |format|
      format.html
    end
  end
  
  def update
    params[:story][:feature_ids] ||= []
    @story = Story.find(params[:id])
    title = @story.title
    respond_to do |format|
      if @story.update_attributes(params[:story])
        flash[:notice] = "Story: #{title} was updated"
        format.html { redirect_to :story }
      else
        flash[:error] = "Story: #{title} was not created"
        format.html { render :action => "edit" }
      end
    end
  end
end