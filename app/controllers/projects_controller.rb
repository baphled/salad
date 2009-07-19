class ProjectsController < ApplicationController
  def index
    @projects ||= Project.find(:all)
  end
  
  def new
    @project = Project.new
  end
  
  def create  
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        flash[:notice] = "#{@project.title} was created"
        format.html { redirect_to @project }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project ||= Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to :project }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
end