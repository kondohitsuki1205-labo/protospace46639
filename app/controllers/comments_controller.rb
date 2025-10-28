class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment   = @prototype.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to prototype_path(@prototype)
    else
      @comments = @prototype.comments.order(:created_at)
      render "prototypes/show", status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)  # ← content に統一
  end
end