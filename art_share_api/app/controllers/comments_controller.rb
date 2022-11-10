class CommentsController < ApplicationController
  def index
    if params.has_key?(:artwork_id)
      comments = Comment.show_comments_for_artwork(params[:artwork_id])
      render json: comments
    end

    if params.has_key?(:user_id)
      comments = Comment.show_comments_for_commenter(params[:user_id])
      render json: comments
    end
  end

  def create
    comment = Comment.new(comment_params)
    if comment.nil?
      render json: {message: "comment not created"}, status: 422
    else
      if comment&.save!
        # redirect_to comment_url(comment.id)
        show(comment.id)
      else
        render json: comment.errors.full_messages, status: 422
      end
    end

  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.nil?
      render json: {message: "comment not found"}, status: unprocessable_entity
    else
      if comment.destroy
        # redirect_to comment_url(comment.id)
        render json: comment
      else
        render json: comment.errors.full_messages, status: unprocessable_entity
      end
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:body, :commenter_id, :artwork_id)
  end

  def show(id)
    comment = Comment.find(id)
    render json: comment
  end
end
