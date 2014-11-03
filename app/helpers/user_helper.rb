module UserHelper
	def get_all
		User.find_all_by_name()
	end
	def get_last
		User.find_last_by_password()
	end
end
