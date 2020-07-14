class RelationshipsController < ApplicationController
	def create
		following = current_user.follow(params[:id])
		if following.save
			redirect_to request.referer
		else redirect_to request.referer
		end
	end

	def destroy
		following = current_user.unfollow(params[:id])
		if following.destroy
			redirect_to request.referer
		else redirect_to request.referer
		end
	end
end
