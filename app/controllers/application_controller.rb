# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  layout :default_or_defined

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
	def tags
		respond_to do |format|
			format.json  { render :json => @tags }
		end
	end

  def default_or_defined
    ("new, create, edit, import".include? action_name)? 'no_sidebar' : 'application'
  end
end
