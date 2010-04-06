class Step < ActiveRecord::Base
	include MyActiveRecordExtensions
  acts_as_taggable
  
  validates_uniqueness_of :title, :on => :create
  validates_presence_of   :title
  validates_format_of     :title,
                          :with => /^(Given|When|Then).*$/,
                          :message => "must start with Given, When or Then"

  validates_length_of :title, :minimum => 12, :too_short => @@error_message
  
  has_many                :step_stories, :order => 'position'
  has_many                :stories, :through => :step_stories
  
  def self.pagination_search search, page
    if search
      Step.paginate(:page => page,:per_page => 10, :conditions => ["title LIKE ?", "%#{search}%"])
    else
      Step.paginate(:page => page,:per_page => 10)
    end
  end
  
  def self.search search
    Step.all(:all,:conditions => ["title LIKE ?", "%#{search}%"])
  end
  
  def first_word
    title.split(" ").first
  end
  
  def convert_prefix
    title.sub first_word, "And"
  end
  
  def formatted last_step
    if !last_step.nil? && last_step.first_word == self.first_word
      return "    #{self.convert_prefix}\n"
    else
      return "    #{title}\n"
    end
  end
end