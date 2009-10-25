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
  
  def find_features
    list = []
    Dir.new("#{self.location}/features").entries.each do |file|
      @feature_title,@in_order,@as_a,@i_want = nil
      @scenarios = []
      if file =~ /^(.*).feature$/
        import file
        list << {:file => file,
                 :feature_title =>@feature_title.sub(/^Feature: /,""),
                 :in_order =>@in_order,
                 :as_a => @as_a,
                 :i_want => @i_want,
                 :scenarios => @scenarios}
      end
    end
    list
  end
  
  def import file
    File.new("#{self.location}/features/#{file}").each do |line|
      if line.strip =~ /^Feature: /
        @feature_title = line.strip
      elsif @in_order.nil? and line.strip =~ /^In order/
        @in_order = line.strip
      elsif @as_a.nil? and line.strip =~ /^As a/
        @as_a = line.strip
      elsif @i_want.nil? and line.strip =~ /^I want/
        @i_want = line.strip
      elsif line.strip =~ /^Scenario: /
        @scenarios << {:story => line.strip,:steps => [] }
      elsif line.strip =~ /^(Given|When|Then|And)/
          @scenarios.last[:steps] << line.strip
      end
    end
  end
end