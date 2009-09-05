module StepsHelper
  include ApplicationHelper
  def viewable_link link_text, view_id
    render :partial => '/common/viewable_link', 
    			 :locals => {:view_id => view_id, :link_text => link_text}
  end
  
  
  def format_step step
    @_title = Feature::format_step step,@last_step
    @last_step = step
    @_title
  end
end