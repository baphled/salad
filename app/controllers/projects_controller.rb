class ProjectsController < ApplicationController
  def index
    @project = Project.new
  end
  
  def new
    
  end
  
  def create
    @project = Project.new params[:project]
    @project.save
  end
end