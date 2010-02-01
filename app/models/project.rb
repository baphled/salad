class Project < ActiveRecord::Base
  @error_message = "Please enter at least {{count}} characters."
	include MyActiveRecordExtensions
  acts_as_taggable
  
  validates_presence_of     :title
  validates_presence_of     :description
  validates_presence_of     :aim
  validates_uniqueness_of   :title

  validates_length_of :title, :minimum => 3, :too_short => @error_message
  validates_length_of :aim, :minimum => 6, :too_short => @error_message
  validates_length_of :description, :minimum => 12, :too_short => @error_message

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

  def self.directory_is_valid? directory
    errors.add(:discount, "can't be greater than total value") if
      File.directory directory
  end
end