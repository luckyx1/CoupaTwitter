module TweetHelper
	def get_or_make
		Tweet.find_or_initialize_by_text()
	end

	def get_or_create
		Tweet.find_or_create_by_text
	end
	RAILS_DEFAULT_LOGGER
end
