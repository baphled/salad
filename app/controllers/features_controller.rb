class FeaturesController < ApplicationController

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
    @feature = Feature.find(params[:id])
  end
  
  def show
    @feature = Feature.find params[:id]
  end
  
  def update
    @feature = Feature.find(params[:id])
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
end