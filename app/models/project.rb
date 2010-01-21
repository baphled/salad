class Project < ActiveRecord::Base
	include MyActiveRecordExtensions
  acts_as_taggable
  
  validates_presence_of     :title
  validates_presence_of     :description
  validates_presence_of     :aim
  validates_uniqueness_of   :title

  has_many :feature_projects
  has_many :features, :through => :feature_projects
  
  def import_features
    list = []
    feature_files = File.join("#{self.location}", "features", "**", "*.feature")
      Dir.glob(feature_files).each do |file|
        featurefile = FeatureFile.new file
        list << {:file => File.basename(file), :feature => featurefile.export}
      end
    list
  end
end