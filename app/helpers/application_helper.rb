# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
  
	def form_title item, title
		(item.id)? "Edit #{title}"  : "New #{title}"
	end

  # TODO rename so that is is more readable or refactor so that is is part of our models
  def model_name_to_sym models
    models.first.class.to_s.downcase.to_sym
  end

  def display_item_title item
    item.class.to_s.eql?('Story')? item.scenario : item.title
  end
end
