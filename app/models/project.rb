class Project < ActiveRecord::Base
	include MyActiveRecordExtensions
  acts_as_taggable
  
  validates_presence_of     :title
  validates_presence_of     :description
  validates_presence_of     :aim
  validates_uniqueness_of   :title

  validates_length_of :title, :minimum => 3, :too_short => :too_short
  validates_length_of :aim, :minimum => 6, :too_short => :too_short
  validates_length_of :description, :minimum => 12, :too_short => :too_short

  validate :directory_is_valid?, :if => :directory_present?

  has_many :feature_projects, :order => 'position'
  has_many :feature_projects, :order => 'position'
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

  def directory_is_valid?
    errors.add(:location, "Must be a valid project location on your system.") if
      File.directory?(self.location) == false
  end

  def directory_present?
    self.location.blank? == false
  end

  # @TODO refactor so that we get a list of feature file names instead of using import_features
  def features_to_import?
    result = false
    features_list = self.import_features
    features_list.each do |feature|
      if not Feature.find_by_path feature[:feature].path
        result = true
      end
    end
    result
  end
end