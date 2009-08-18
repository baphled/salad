# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
  
  def viewable_link link_text, view_id
    render :partial => '/common/viewable_link', 
    			 :locals => {:view_id => view_id, :link_text => link_text}
  end
  
  def order_btn object, order
    if !object.blank?
      render :partial => '/common/order', :locals => {:order => order}
  	end
  end
end
