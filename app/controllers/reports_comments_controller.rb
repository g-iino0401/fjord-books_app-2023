class ReportsCommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Report.find(params[:report_id])
  end

  def render_commentable_page
    redirect_to report_path(@commentable)
  end
end
