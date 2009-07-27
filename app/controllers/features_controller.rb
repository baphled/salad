class FeaturesController < ApplicationController
  def new
    @feature = Feature.new
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