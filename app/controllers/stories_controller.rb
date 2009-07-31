class StoriesController < ApplicationController
  before_filter :find_story, :except => [:index,:new,:create]
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
  end
  
  def edit
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
  
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to(stories_path) }
      format.xml  { head :ok }
    end
  end
  
  private
    def find_story
      @story = Story.find(params[:id])
      
    end
end