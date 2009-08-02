class StepsController < ActionController::Base
  before_filter :find_step, :except => [:index,:new,:create]
  def index
    @steps = Step.all
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @step = Step.new
    @stories = Story.all
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
        format.html { redirect_to @step }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def show
    
  end
  
  private
    def find_step
      @step = Step.find(params[:id])
    end
end