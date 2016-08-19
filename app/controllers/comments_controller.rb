class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new
    @comment = current_user.comments.create content: params[:content],
      product_id: params[:product_id]
    if result = @comment.save
      respond_to do |format|
        format.html{redirect_to root_path}
        format.js {render json: {result: result, content: @comment.content,
          user: current_user.name}}
      end
    else
      respond_to do |format|
        format.html{redirect_to root_path}
        format.js {render json: {result: result}}
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :product_id
  end
end
