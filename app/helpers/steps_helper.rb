module StepsHelper
  include ApplicationHelper
  
  def viewable_link link_text, view_id
    render :partial => '/common/viewable_link', 
    			 :locals => {:view_id => view_id, :link_text => link_text}
  end
  
end