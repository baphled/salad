class ParkingController < ActionController::Base
  layout "application"
  
  def index
    @tickets = LightHouse.find(:all)
  end
  
  def new
    @resource = Resource.new
  end
  
  def tickets
    @resource = Resource.find(params[:resource][:id])
    @tickets = @resource.tickets(params[:tag])
  end
  
  def create
    @resource = Resource.new(params[:resource])
    if @resource.save
      redirect_to parking_index_path
    end
  end
  
  def import
    params[:lighthouse].each do |item|
      if not LightHouse.create(:ticket_id => item, :body => 'foo')
        flash[:error] = "Unable to save tickets"
        redirect_to parking_index_path and return
      end
    end
    flash[:notice] = "Parked tickets"
    redirect_to parking_index_path
  end
  
end
