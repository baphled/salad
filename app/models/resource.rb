class Resource < ActiveRecord::Base
  
  def tickets(tag)
    Lighthouse.account = name
    Lighthouse::Ticket.find(:all, :params => { :project_id => project_id, :q => "state:open tagged:#{tag}" })
  end
  
  def ticket(number)
    Lighthouse.account = self.name
    Lighthouse::Ticket.find(number, :params => { :project_id => project_id})
  end
end