module StepsHelper
  def format_step step
    @_title = Feature::format_step step,@last_step
    @last_step = step
    @_title
  end
end