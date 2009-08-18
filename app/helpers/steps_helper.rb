module StepsHelper
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