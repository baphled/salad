module StepsHelper
  def viewable_link link_text, view_id
    render :partial => '/common/viewable_link', 
    			 :locals => {:view_id => view_id, :link_text => link_text}
  end
  
  def order_btn object, order
    if !object.blank?
      render :partial => '/common/order', :locals => {:order => order}
  	end
  end
  
  def format_step step
    @_title = Feature::format_step step,@last_step
    @last_step = step
    @_title
  end
end