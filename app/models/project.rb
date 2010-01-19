class Project < ActiveRecord::Base
	include MyActiveRecordExtensions
  acts_as_taggable
  
  validates_presence_of     :title
  validates_presence_of     :description
  validates_presence_of     :aim
  validates_uniqueness_of   :title

  has_many :feature_projects
  has_many :features, :through => :feature_projects
  
  @feature_title,@in_order,@as_a,@i_want,@scenarios,@steps = nil

  def import_features
    list = []
    Dir.new("#{self.location}/features/plain").entries.each do |file|
      if file =~ /^(.*).feature$/
        file = FeatureFile.new "#{self.location}/features/plain/#{file}"
        list << {:file => File.basename(file.path), :feature => file.export}
      end
    end
    list
  end
  
end