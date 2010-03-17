module MyActiveRecordExtensions
	@@error_message = "Please enter at least {{count}} characters."
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

module Enumerable
  def dups
    inject({}) {|h,v| h[v]=h[v].to_i+1; h}.reject{|k,v| v==1}.keys
  end
end
