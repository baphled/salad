# To change this template, choose Tools | Templates
# and open the template in the editor.

class ParkingController < ActionController::Base
  layout "application"
  
  def new
    @resource = Resource.new
  end
  
  def tickets
    @tickets = Lighthouse::Ticket.find(:all, :params => { :project_id => '50164', :q => "state:open tagged:#{params[:tag]}" })
  end
end
