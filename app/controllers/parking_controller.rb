class ParkingController < ApplicationController
  
  navigation :parking
  
  def index
    @tickets = LightHouse.all
    @resources = Resource.all
  end
  
  def new
    @resource = Resource.new
  end
  
  def tickets
    @resource = Resource.find(params[:resource][:id])
    puts params[:resource][:id]
    @tickets = @resource.tickets(params[:parking][:tag])
    if @tickets.nil?
      flash[:notice] = 'No tickets available'
    end
  end
  
  def create
    @resource = Resource.new(params[:resource])
    respond_to do |format|
      if @resource.save
        format.html { redirect_to parking_index_path }
        format.js { render "create.rjs" }
      else
        format.html { render :action => "new" }
      end
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

  def unique_resource_name
    result = true
    if Resource.find_by_name params[:name]
      result = 'Must be a unique resource name.'
    end
    render :json => result.to_json
  end
end
