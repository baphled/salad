class FeaturesController < ApplicationController
  before_filter :find_feature, :except => [:index,:new,:create,:sort,:tag]
  
  before_filter :find_tag
  
  def index
    @features = Feature.all
    respond_to do |format|
      format.html
    end
  end
  
  def new
    if !params[:project_id].nil? && !Project.find(params[:project_id]).nil?
      @feature = Feature.new
      @feature.projects << Project.find(params[:project_id])
    else
      @feature = Feature.new
    end
    @projects = Project.find :all
  end
  
  def create
    @feature = Feature.new(params[:feature])
    respond_to do |format|
      if @feature.save
        flash[:notice] = "Feature: #{@feature.title}, was created"
        format.html { redirect_to @feature }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
  end
  
  def show
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
  end
  
  def sort
    params[:features].each_with_index do |id, index|
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