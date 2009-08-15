module StepsHelper
  def format_step step
    if !@last_step.nil? && @last_step.title.split(" ").first == step.title.split(" ").first
      @_title = "    #{step.title.sub(step.title.split(" ").first, "And")}\n"
    else
      @_title = "    #{step.title}\n"
    end
    @last_step = step
    @_title
  end
end