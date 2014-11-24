module ApplicationHelper
	def get_all_of_everything
		@var = scoped_by_name()
		RAILS_ROOT
	end

	def something
		  File.join(RAILS_ROOT, 'config/database.yml')
	end

	def other
		  RAILS_ROOT + 'config/database.yml'
	end
end
