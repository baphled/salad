class Resource < ActiveRecord::Base
  validates_presence_of     :name
  validates_presence_of     :project_id

  validate :valid_lighthouse_account?, :if => :name_not_empty?
  validate :valid_lighthouse_project_id?, :if => :project_id_not_empty?

  def tickets(tag)
    Lighthouse.account = name
    Lighthouse::Ticket.find(:all, :params => { :project_id => project_id, :q => "state:open tagged:#{tag}" })
  end
  
  def ticket(number)
    Lighthouse.account = self.name
    Lighthouse::Ticket.find(number, :params => { :project_id => project_id})
  end

  def valid_lighthouse_account?
    begin
      Lighthouse.account = self.name
      Lighthouse::Project.find :all
    rescue ActiveResource::UnauthorizedAccess
      errors.add(:name, "Must be a valid LightHouse project name")
    end
  end

  def valid_lighthouse_project_id?
    begin
      Lighthouse.account = self.name
      Lighthouse::Project.find self.project_id
    rescue ActiveResource::ResourceNotFound
      errors.add(:project_id, "Must be a valid LightHouse project id")
    end
  end
  
  private
    def name_not_empty?
      (self.name == '')? false : true
    end

    def project_id_not_empty?
      (self.project_id  == '' or self.name == '')? false : true
    end
end