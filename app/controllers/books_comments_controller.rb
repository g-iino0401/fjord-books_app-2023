class BooksCommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Book.find(params[:book_id])
  end

  def render_commentable_page
    redirect_to book_path(@commentable)
  end
end
