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