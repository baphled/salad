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

  validate :directory_is_valid, :if => :directory_present?

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

  def directory_is_valid
    errors.add(:location, "Must be a valid project location on your system.") if
      File.directory?(self.location) == false
  end

  def directory_present?
    self.location.blank? == false
  end
end