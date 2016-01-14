class SearchController < ApplicationController
	def search
		if params[:q].nil?
			@results = []
		else
			@results = Page.search(params[:q])
		end
	end
end
