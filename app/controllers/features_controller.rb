class FeaturesController < ApplicationController

  navigation :features

  before_filter :find_feature, :except => [:index, :new, :create, :tag, :tags, :validate, :import, :sync]
  before_filter :find_features_stories, :only => [:show, :update, :stories]
  before_filter :find_tag

#  after_filter :find_features_stories, :only => [:sync]
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
      @feature = Feature.new(:title => params[:title])
    end
    @projects = Project.all
  end

  # @TODO Refactor so that we have an import action that handles our import related functionality
  def create
    @feature = Feature.new(params[:feature])
    respond_to do |format|
      if @feature.save
        find_features_stories
        flash[:notice] = "Feature: #{@feature.title}, was created"
        format.js { render "create.rjs" }
        format.html { redirect_to @feature }
      else
        flash[:notice] = "Feature: #{@feature.title}, was not created"
        format.js { render :action => "new" }
        format.html { render :action => "new" }
      end
    end
  end

  def sync
    @feature = Feature.new(params[:feature])
    respond_to do |format|
      if @feature.save
        find_features_stories
        # Need to review he below line, im sure it could be written better
        @project = Project.find(params[:current_project_id]) unless params[:current_project_id].nil?
        if not @project.features_to_import?
          flash[:notice] = "No more features to import"
          format.html { redirect_to feature_path @feature }
          format.js { render "index.rjs" }
        else
          flash[:notice] = "Feature: #{@feature.title}, was imported"
          format.html { redirect_to :back }
          format.js { render "import.rjs" }
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
      format.feature { send_data @feature.export, :filename => @feature.title + '.feature' }
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
      @pretty = @feature.diff_reverse
    else
      flash[:error] = "No changes available"
      redirect_to feature_path @feature
    end
  end

  def system_merge
    if @feature.is_diff?
      @pretty = @feature.diff
    else
      flash[:notice] = "No changes available"
      redirect_to feature_path(@feature)
    end
  end

  def system_sync
    if not @feature.is_diff?
      flash[:notice] =  "Feature does not need updating"
    end
    if @feature.sync_system
      flash[:success] = "The system feature has successfully been updated"
    else
      flash[:error] = "Unable to update the system feature"
    end
      redirect_to feature_path(@feature)
  end

  def file_merge
    if params[:dry_run]
      if @feature.sync(params[:dry_run])
        flash[:notice] = "No errors whilst doing dry-run"
        redirect_to merge_feature_path(@feature)
      else
        flash[:error] = "Unable to merge changes"
        redirect_to feature_path @feature
      end
    else
      if @feature.sync(false)
        flash[:notice] = "Feature has been patched"
        redirect_to feature_path @feature
      else
        flash[:error] = "Errors encountered whilst patching file"
        redirect_to merge_feature_path(@feature)
      end
    end
  end

  def source
    @file = File.read(@feature.path)
    respond_to do |format|
      format.html
      format.js { render :json => @file.to_json }
    end
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