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
      feature_line,in_order = nil
      if file =~ /^(.*).feature$/
        File.new("#{self.location}/features/#{file}").each do |line|
          if line =~ /^Feature: /
            feature_line = line
          end
          if line =~ /In order/
            in_order = line
          end
          
        end
        list << {:file => file,
                 :feature_line =>feature_line.sub(/^Feature: /,""),
                 :in_order =>in_order}
      end
    end
    list
  end
end