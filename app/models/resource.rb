class Resource < ActiveRecord::Base
  def tickets(tag)
    Lighthouse.account = name
    Lighthouse::Ticket.find(:all, :params => { :project_id => project_id, :q => "state:open tagged:#{tag}" })
  end
end