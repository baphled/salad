class Project < ActiveRecord::Base
  acts_as_taggable
  
  validates_presence_of     :title
  validates_presence_of     :description
  validates_presence_of     :aim
  validates_uniqueness_of   :title

  has_many :feature_projects
  has_many :features, :through => :feature_projects
  
  def find_features
    list = []
    Dir.new("#{self.location}/features").entries.each do |file|
      list << file unless not file =~ /^(.*).feature$/
    end
    list
  end
end