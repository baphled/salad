class FeaturesController < ApplicationController

  navigation :features

  before_filter :find_feature, :except => [:index, :new, :create, :tag, :tags, :validate, :import]
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
          format.html { redirect_to @feature }
          format.js { render "create.rjs" }
        else
          format.html { redirect_to :back }
          format.js { render "index.rjs" }
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
    respond_to do |format|
      format.html
      format.patch { handle_patch_view(@feature) }
      format.feature { render :text => @feature.export }
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
    respond_to do |format|
      format.html
      format.txt { render :text => "#{@feature.export}" }
    end
  end
  
  def sort
    params[:feature].each_with_index do |id, index|
      @feature.feature_projects.update_all(['position=?', index+1])
    end
    render :nothing => true
  end
  
  def tag
    @features = Feature.find_tagged_with params[:tag]
    render :index
  end

  def changes
    if @feature.is_diff?
      @pretty = @feature.diff_reverse
    else
      flash[:error] = "No changes available"
      redirect_to feature_path @feature
    end
  end

  def import
    @feature = FeatureFile.new(params[:path]).export
  end

  def merge
    if @feature.is_diff?
      @pretty = @feature.diff
    else
      flash[:error] = "No changes available"
      redirect_to feature_path @feature
    end
  end
  
  def file_merge
    if @feature.sync
      flash[:notice] = "Feature merged"
    else
      flash[:error] = "Unable to merge changes"
    end
    redirect_to feature_path @feature
  end
  
  def validate
    result = true
    if Feature.find_by_title params[:title]
        result = "Must be a unique feature."
    end
    render :json => result.to_json
  end
  
  private
    def handle_patch_view feature
      if feature.is_diff?
        render :text => feature.patch
      else
        flash[:error] = 'No patch available'
        redirect_to feature_path(feature)
      end
    end
    
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