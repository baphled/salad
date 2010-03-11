class FeaturesController < ApplicationController
  navigation :features
  
  before_filter :find_feature, :only => [:edit, :show, :update, :destroy, :stories, :export]
  before_filter :find_features_stories, :only => [:show, :stories]

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
        find_features_stories
        if "Submit" == params[:commit]
          format.js { render "create.rjs" }
          format.html { redirect_to @feature }
        else
          format.js { render "create.rjs" }
          format.html { redirect_to :back }
        end
      else
        format.js { render :action => "edit" }
        format.html { render :action => "edit" }
      end
    end
  end
  
  def edit
  end
  
  def show
    if @feature.is_diff?
      flash[:notice] = 'This feature has been changed.'
    end
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
        format.js { render "create.rjs" }
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
  
  def validate
    result = true
    if Feature.find_by_title params[:title]
        result = "Must be a unique feature."
    end
    render :json => result.to_json
  end
  
  private
    def find_tag
      @tags = Feature.tag_counts
    end
  
    def find_feature
      @feature = Feature.find(params[:id])
    end

    def find_features_stories
      @feature_stories = @feature.stories.paginate(:page=>params[:page],:per_page=>5, :order=>"feature_stories.position")
    end
end