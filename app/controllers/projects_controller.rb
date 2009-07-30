class ProjectsController < ApplicationController
  
  before_filter :find_project, :except => [:index,:new,:create]
  
  def index
    @projects = Project.find(:all)
  end
  
  def new
    @project = Project.new
    @features = Feature.find :all
  end
  
  def create  
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        flash[:notice] = "Project: #{@project.title} was created"
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
    title = @project.title
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = "Project: #{title} was updated"
        format.html { redirect_to :project }
      else
        flash[:error] = "Project: #{title} was not created"
        format.html { render :action => "edit" }
      end
    end
  end
  
  def show
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def features
    @project = Project.find(params[:id])
    @features = @project.features
    respond_to do |format|
      format.html
    end
  end
  
  private
    def find_project
      @project = Project.find(params[:id])
    end
end