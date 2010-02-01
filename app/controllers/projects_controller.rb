class ProjectsController < ApplicationController
  
  before_filter :find_project, :except => [:index,:new,:create,:tag,:tags, :valid_directory]
  
  before_filter :find_tags
  
  def index
    @projects = Project.find(:all)
  end
  
  def new
    @project = Project.new
    @features ||= Feature.find :all
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
  end
  
  def update
    title = @project.title
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = "Project: #{title} was updated"
        format.html { redirect_to @project }
      else
        flash[:error] = "Project: #{title} was not created"
        format.html { render :action => "edit" }
      end
    end
  end
  
  def show
  end
	
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_path) }
      format.xml  { head :ok }
    end
  end
  
  def features
    @project_features = @project.features.all(:order=>"feature_projects.position")
  end
  
  def import
    @feature = @project.features.new(:projects=>[@project])
    @imported = @project.import_features
  end
  	
  def tag
    @projects = Project.find_tagged_with params[:tag]
    render :index
  end

  def valid_directory
    result = ""
    if not File.directory?(params[:location])
        result = "Must be a valid project location on your system."
    end
    respond_to do |format|
      format.json  { render :json => result.to_json }
    end
  end

  private
  
    def find_tags
      @tags ||= Project.tag_counts
    end
    
    def find_project
      @project ||= Project.find(params[:id])
    end
end