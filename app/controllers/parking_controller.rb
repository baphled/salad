class ParkingController < ActionController::Base
  layout "application"
  
  def index
    @tickets = LightHouse.all
    @resources = Resource.all
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
    @resource = Resource.find(params[:resource][:id])
    params[:lighthouse][:ticket_id].each do |item|
      ticket = @resource.ticket(item)
      if not LightHouse.create(:ticket_id => item, :title => ticket.title, :body => ticket.original_body)
        flash[:error] = "Unable to save tickets"
        redirect_to parking_index_path and return
      end
    end
    flash[:notice] = "Parked tickets"
    redirect_to parking_index_path
  end
  
end
