# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
  
  def order_btn object, order
    if !object.blank?
      render :partial => '/common/order', :locals => {:order => order}
  	end
  end

	def form_title item, title
		if item.id
			"Edit " + title
		else
			"New " + title
		end
	end

  # TODO rename so that is is more readable or refactor so that is is part of our models
  def model_name_to_sym models
    models.first.class.to_s.downcase.to_sym
  end

  def display_item_title item
    if 'Story' == item.class.to_s
      item.scenario
    else
      item.title
    end
  end
end
