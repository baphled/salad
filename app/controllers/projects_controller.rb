class ProjectsController < ApplicationController
  navigation :projects
  
  before_filter :find_project, :except => [:index,:new,:create,:tag,:tags, :valid_directory, :validate]
  
  before_filter :find_tags
  before_filter :find_projects_features, :only => [:update,:show, :features]
  def index
    @projects = Project.paginate(:page => params[:page],:per_page => 5)
  end
  
  def new
    @project = Project.new
    @features ||= Feature.find :all
  end
  
  def create  
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        find_projects_features
        flash[:notice] = "Project: #{@project.title} was created"
        format.js { render "create.rjs" }
        format.html { redirect_to @project }
      else
        format.js { render :action => "new" }
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
        format.js { render "create.rjs" }
        format.html { redirect_to @project }
      else
        flash[:error] = "Project: #{title} was not created"
        format.html { render :action => "edit" }
      end
    end
  end
  
  def show
    @to_import = Feature.imports_found @project.location
    respond_to do |format|
      format.html
      format.js { render "show.rjs" }
    end
  end
	
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to(projects_path) }
      format.xml  { head :ok }
    end
  end
  
  def features
    respond_to do |format|
      format.html
      format.js { render "show.rjs" }
    end
  end
  
  def import
    @feature = @project.features.new(:projects=>[@project])
    @imported = @project.import_features
  end

  def to_import
    @to_import = Feature.imports_found @project.location
    render :import
  end
  
  def tag
    @projects = Project.find_tagged_with params[:tag]
    render :index
  end

  def valid_directory
    result = true
    if not File.directory?(params[:location])
      result = %{false, "Must be a valid project location on your system."}
    end
    render :json => result.to_json
  end

  def validate
    result = true
    if Project.find_by_title params[:title]
        result = "Must be a unique project."
    end
    render :json => result.to_json
  end
  
  private
  
    def find_tags
      @tags ||= Project.tag_counts
    end
    
    def find_project
      @project ||= Project.find(params[:id])
    end

    def find_projects_features
      @project_features = @project.features.paginate(:page => params[:page],:per_page => 5,:order=>"feature_projects.position")
    end
end