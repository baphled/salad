class StepsController < ActionController::Base
  before_filter :find_step, :except => [:index,:new,:create,:sort]
  
  layout "application"
  
  def index
    @search = Step.search(params[:search_text])
    @steps = Step.pagination_search(params[:search_text],params[:page])
    respond_to do |format|
      format.html
      format.json { render :json => @steps }
    end
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
        format.html { redirect_to :stories }
      else
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
        format.html { redirect_to :step }
      else
        flash[:error] = "Step: #{title} was not created"
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
    params[:steps].each_with_index do |id, index|
      @steps = Step.find id
      @steps.step_stories.update_all(['position=?', index+1])
    end
    render :nothing => true
  end
  
  private
    def find_step
      @step = Step.find(params[:id])
    end
end