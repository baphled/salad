class StepsController < ActionController::Base
  before_filter :find_step, :except => [:index,:new,:create,:sort, :validate_prefix, :tags, :tag]

  before_filter :find_tags
  
  layout "application"
  
  def index
    @search = Step.search(params[:search_text])
    @steps = Step.paginate(:page => params[:page],:per_page => 5)
  end
  
  def new
    if not params[:story_id].nil?
      @story = Story.find(params[:story_id])
      @step = @story.steps.new(:story_ids => [params[:story_id]])
    else
      @step = Step.new
    end
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    
  end
  
  def create
   @step = Step.new(params[:step])
    respond_to do |format|
      if @step.save
        flash[:notice] = "Step: #{@step.title}, was created"
        format.js { render "create.rjs" }
        format.html { redirect_to step_path(@step) }
      else
        format.js { render :action => "new" }
        format.html { render :action => "new" }
      end
    end
  end
  
  def show
    
  end
  
  def update
    params[:step][:story_ids] ||= []
    title = @step.title
    respond_to do |format|
      if @step.update_attributes(params[:step])
        flash[:notice] = "Step: #{title} was updated"
        format.js { render "create.rjs" }
        format.html { redirect_to @step }
      else
        flash[:error] = "Step: #{title} was not updated"
        format.js { render :action => "edit" }
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @step.destroy
    respond_to do |format|
      format.html { redirect_to(steps_path) }
      format.xml  { head :ok }
    end
  end
  
  def sort
    params[:step].each_with_index do |id, index|
      @steps = Step.find id
      @steps.step_stories.update_all(['position=?', index+1])
    end
    render :nothing => true
  end

  def validate_prefix
    result = true
    if (params[:title].split(" ").first =~ /^(Given|When|Then).*$/) == nil
      result = "must start with Given, When or Then"
    end
      render :json => result.to_json
  end

  def tag
    @steps = Step.find_tagged_with params[:tag]
    render :index
  end

  private
    def find_tags
      @tags = Step.tag_counts
    end
    
    def find_step
      @step = Step.find(params[:id])
    end
end