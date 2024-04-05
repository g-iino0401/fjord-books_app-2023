# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      flash[:alert] = "コメントが登録できません。"
      render_commentable_page
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
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
      Book.find_by!(id: params[:book_id])
    elsif params[:report_id]
      Report.find_by!(id: params[:report_id])
    end
  end

  def render_commentable_page
    if @commentable.is_a?(Book)
      redirect_to book_path(@commentable)
    elsif @commentable.is_a?(Report)
      redirect_to report_path(@commentable)
    end
  end
end
