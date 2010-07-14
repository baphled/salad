#
# Extended functionality to display our dates in a human readable fashion.
#
# @todo Maybe a good idea to extend ActiveRecord so that we do not need to include this in all of our models
#
module MyActiveRecordExtensions
	def creation_date
		if not self.created_at.to_s.empty?
			self.created_at.to_s :long
		end
	end
	
	def updated_date
		if not self.updated_at.to_s.empty?
			self.updated_at.to_s :long
		end
	end
end

#@todo Move into its own file
module Enumerable
  def dups
    inject({}) {|h,v| h[v]=h[v].to_i+1; h}.reject{|k,v| v==1}.keys
  end
end
