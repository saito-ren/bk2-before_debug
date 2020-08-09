class BookCommentsController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		@comment = @book.book_comments.new(book_comment_params)
		@comment.user_id = current_user.id
		if @comment.save
		   flash[:success] = "Comment was successfully created."
		   redirect_to request.referer
        else
           @book_new = Book.new
           @book_comments = @book.book_comments
           render '/books/show'
       end
	end

	def destroy
		book = Book.find(params[:book_id])
		@comment = BookComment.find(params[:id])
		if @comment.user == current_user
		   @comment.destroy
		end
		redirect_to request.referer
		
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end
