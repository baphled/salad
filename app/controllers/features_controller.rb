class FeaturesController < ApplicationController
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
  
  def show
    
  end
end