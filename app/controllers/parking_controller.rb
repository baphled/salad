class ParkingController < ActionController::Base
  layout "application"
  
  def new
    @resource = Resource.new
  end
  
  def tickets
    @resource = Resource.new(:name => 'baphled', :project_id => '50164')
    @tickets = @resource.tickets(params[:tag])
  end
  
  def create
    @resource = Resource.new(params[:resource])
    if @resource.save
      redirect_to parking_index_path
    end
  end
end
