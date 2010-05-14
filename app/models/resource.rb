class Resource < ActiveRecord::Base
  
  def self.tickets(user_name, project_id, tag)
    Lighthouse.account = user_name
    Lighthouse::Ticket.find(:all, :params => { :project_id => project_id, :q => "state:open tagged:#{tag}" })
  end
end