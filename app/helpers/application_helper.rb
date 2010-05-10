# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
  
  def order_btn object, order
    render :partial => '/common/order', :locals => {:order => order} if !object.blank?
  end

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
  
  def link_to_with_tooltip(link_title, link, tooltip)
    link_to link_title, link.capitalize, :id => link_title.gsub(' ', '-').downcase, :title => tooltip
  end
end
