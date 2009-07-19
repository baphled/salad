class ProjectsController < ApplicationController
  def index

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
  
  def show
    @project = Project.find(params[:id])
  end
  
end