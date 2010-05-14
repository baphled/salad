class ParkingController < ActionController::Base
  layout "application"
  
  def new
    @resource = Resource.new
  end
  
  def tickets
    @tickets = Resource.tickets('baphled', '50164', params[:tag])
  end
  
  def create
    @resource = Resource.new(params[:resource])
    if @resource.save
      redirect_to parking_index_path
    end
  end
end
