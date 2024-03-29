# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    return unless @comment.save

    redirect_back(fallback_location: root_path, notice: t('controllers.common.notice_create', name: Comment.model_name.human))
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human))
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_commentable
    @commentable = find_commentable
  end

  def find_commentable
    if params[:book_id]
      Book.find_by(id: params[:book_id])
    elsif params[:report_id]
      Report.find_by(id: params[:report_id])
    end
  end
end
