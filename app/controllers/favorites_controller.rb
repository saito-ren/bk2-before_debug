class FavoritesController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		favorites = @book.favorites.new(user_id: current_user.id)
		favorites.save
		redirect_to request.referer
	end

	# def create
	# 	favorite = Favorite.new
	# 	favorite.user_id = current_user.id
	# 	favorite.book_id = params[:book_id]

	# 	if favorite.save
	# 		redirect_to books_path
	# 	else redirect_to books_path
	# 	end

	# end

	def destroy
		@book = Book.find(params[:book_id])
		favorites = @book.favorites.find_by(user_id: current_user.id)
		favorites.destroy
		redirect_to request.referer
		# redirect_to books_path(@book)
	end

	# def destroy
	# 	@favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
	# 	@favorite.destroy
	# 	redirect_to books_path
	# end
end
