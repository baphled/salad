class ParkingController < ActionController::Base
  layout "application"
  
  def index
    @resources = LightHouse.all
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

      LightHouse.create(:ticket_id => item, :body => 'foo')
    end
    flash[:notice] = "Parked tickets"
    redirect_to parking_index_path
  end
  
end
