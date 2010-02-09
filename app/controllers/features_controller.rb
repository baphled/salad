class FeaturesController < ApplicationController
  before_filter :find_feature, :except => [:index,:new,:create,:sort,:tag, :tags]
  
  before_filter :find_tag
  
  def index
    @features = Feature.paginate(:page => params[:page],:per_page => 5)
    respond_to do |format|
      format.html
      format.js { render "index.rjs" }
    end
  end
  
  def new
    if !params[:project_id].nil? && !Project.find(params[:project_id]).nil?
      @project = Project.find(params[:project_id])
      @feature = @project.features.new
    else
      @feature = Feature.new
    end
    @projects = Project.all
  end
  
  def create
    @feature = Feature.new(params[:feature])
    respond_to do |format|
      if @feature.save
        flash[:notice] = "Feature: #{@feature.title}, was created"
        if "Submit" == params[:commit]
          format.html { redirect_to @feature }
        else
          format.html { redirect_to :back }
        end
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def edit
  end
  
  def show
    @feature_stories = @feature.stories.paginate(:page=>params[:page],:per_page=>5,:order=>"feature_stories.position")
    respond_to do |format|
      format.html
      format.js { render "show.rjs" }
    end
  end
  
  def update
    title = @feature.title
    respond_to do |format|
      if @feature.update_attributes(params[:feature])
        flash[:notice] = "Feature: #{title}, was updated"
        format.html { redirect_to @feature }
      else
        flash[:error] = "Feature: #{title}, was not updated"
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @feature.destroy
    respond_to do |format|
      format.html { redirect_to(features_path) }
      format.xml  { head :ok }
    end
  end
  
  def stories
    @feature_stories = @feature.stories.paginate(:page=>params[:page],:per_page=>5, :order=>"feature_stories.position")
    respond_to do |format|
      format.html
      format.js { render "show.rjs" }
    end
  end
  
  def export
  end
  
  def sort
    params[:feature].each_with_index do |id, index|
      @feature = Feature.find id
      @feature.feature_projects.update_all(['position=?', index+1])
    end
    render :nothing => true
  end
  
  def tag
    @features = Feature.find_tagged_with params[:tag]
    render :index
  end
  
  private
    def find_tag
      @tags = Feature.tag_counts
    end
  
    def find_feature
      @feature = Feature.find(params[:id])
    end
end