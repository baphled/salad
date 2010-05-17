class ParkingController < ActionController::Base
  layout "application"
  
  def index
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
    params[:ticket_item].each do |item_id|
      LightHouse.create(:ticket_id => item_id, :body => 'foo')
    end
    flash[:notice] = "Parked tickets"
  end
  
end
