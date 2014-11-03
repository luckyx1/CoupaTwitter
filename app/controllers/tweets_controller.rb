class TweetsController < ApplicationController
	def index
		@tweet = Tweet.all
	end

	def update
		render :update do |page|
  			page.remove "financial_tran_offset_#{params[:ftof_id]}"
  			page.replace_html 'details', :partial => 'details', :locals => {:obj => @fire}
		end
	end
end
