# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
  
  def order_btn object, order
    if !object.blank?
      render :partial => '/common/order', :locals => {:order => order}
  	end
  end
end
