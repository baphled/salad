class Example < ActiveRecord::Base
  has_many :action_examples
  has_many :actions, :through => :action_examples

  belongs_to :story

  accepts_nested_attributes_for :actions
end