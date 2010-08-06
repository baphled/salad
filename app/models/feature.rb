require 'pretty_diff'

class Feature < ActiveRecord::Base
	include MyActiveRecordExtensions
  acts_as_taggable

  validates_uniqueness_of   :title, :on => :create
  
  validates_presence_of     :title
  validates_presence_of     :in_order
  validates_presence_of     :as_a
  validates_presence_of     :i_want
  
  validates_associated      :stories, :on => :create

  validates_length_of :title, :minimum => 4, :too_short => :too_short
  validates_length_of :in_order, :minimum => 7, :too_short => :too_short
  validates_length_of :as_a, :minimum => 4, :too_short => :too_short
  validates_length_of :i_want, :minimum => 7, :too_short => :too_short
  
  validate :is_unique?
  validate :valid_feature_path?

  has_many :feature_projects, :order => 'position'
  has_many :projects, :through => :feature_projects
  
  has_many :feature_stories, :order => 'position'
  has_many :stories, :through => :feature_stories

  accepts_nested_attributes_for :stories, :allow_destroy => true
  
  def export
    exported = feature_title
    self.stories.each do |story|
      exported += "#{feature_scenarios story}"
      exported += "#{feature_examples story}"
    end
    exported.rstrip
  end

  def is_diff?
    if not self.path.nil?
      generate_diff
      result = %x{diff -uaw "#{self.path}" "#{RAILS_ROOT}/tmp/#{File.basename(self.path)}.tmp"}
      (result.empty?)? false : true
    end
  end

  def patch
    generate_diff
    %x{diff -uaw "#{self.path}" "#{RAILS_ROOT}/tmp/#{File.basename(self.path)}.tmp"}
  end
  
  def get_source_file
    File.read self.path if not self.path.nil?
  end

  def diff
    generate_diff
    result = %x{diff -uaw "#{RAILS_ROOT}/tmp/#{File.basename(self.path)}.tmp" "#{self.path}"}
    PrettyDiff::Diff.new(result)
  end
  
  def diff_reverse
    generate_diff
    result = %x{diff -uaw "#{self.path}" "#{RAILS_ROOT}/tmp/#{File.basename(self.path)}.tmp"}
    PrettyDiff::Diff.new(result)
  end
  
  def self.imports_found project_path
    found = []
    feature_files = File.join("#{project_path}", "features", "**", "*.feature")
    Dir.glob(feature_files).each { |file| found << FeatureFile.new(file).export if Feature.find_by_path(file).nil? }
    found
  end

  def sync(dry_run = true)
    if self.patch.nil? or self.patch.empty?
      false
    else
      (run_patch(dry_run).include? 'patching file')? true : false
    end
  end

  def sync_system
    self.stories.destroy_all
    feature = FeatureFile.new(self.path).export
    self.stories = feature.stories
    self.update_attributes(feature.attributes)
  end
  
  protected
    def run_patch dry_run
      File.open("#{RAILS_ROOT}/tmp/#{File.basename(self.path)}.patch", 'w') { |f| f.write(self.patch) }
      if dry_run
        %x{patch --dry-run -p1 "#{self.path}" -i "#{RAILS_ROOT}/tmp/#{File.basename(self.path)}.patch"}
      else
        %x{patch -p1 "#{self.path}" -i "#{RAILS_ROOT}/tmp/#{File.basename(self.path)}.patch"}
      end
    end
    
  private
    def generate_diff
      FileUtils.touch("#{RAILS_ROOT}/tmp/#{File.basename(self.path)}.tmp")
      file = File.new("#{RAILS_ROOT}/tmp/#{File.basename(self.path)}.tmp", 'w')
      file.write(self.export)
      file.close  
    end

    def valid_feature_path?
      if not self.path.nil?
        errors.add(:path, "Must be a valid feature location on your system.") if not File.file? self.path
      end
    end
    
    def is_unique?
      Feature.find_by_title self.title == nil
    end
    
    def feature_scenarios story
      result = (story.example.blank?)? "\n  Scenario:" : "\n  Scenario Outline:"
      result += " #{story.scenario}\n#{story_titles story}"unless story.steps.blank?
    end

    def feature_examples story
      if not story.example.nil?
        result = "\n\t\tExamples: #{story.example.heading.lstrip}\n"
        story.example.actions.each { |action| result += "\t\t| #{action.title}" }
        result += " |\n"
        story.example.actions.first.items.each_with_index do |item, index|
          story.example.actions.each do |action|
            result += "\t\t| #{action.items[index].title}"
          end
          result += " |\n"
        end
        result
      end
    end

    def story_titles story
      titles = ""
			last_step = nil
      story.steps.each do |step|
        titles += "#{step.formatted(last_step)}"
        last_step = step
      end
      titles
    end
    
    def feature_title
      head = "Feature: #{title.lstrip}\n\  In order #{in_order.lstrip}\n"
      head += "\  As #{as_a.lstrip}\n\  I want #{i_want.lstrip}\n"
    end
end