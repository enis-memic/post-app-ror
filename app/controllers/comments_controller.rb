class CommentsController < ApplicationController
  load_and_authorize_resource
  def new
    @post = Post.find(params[:post_id])
    if user_signed_in?
      @comments = Comment.new
    else
      redirect_to new_user_session_path, alert: "You need to sign in to add a comment."
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comments = @post.comments.build(comment_params)
    @comments.author_id = current_user.id

    if @comments.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comments = @post.comments.find(params[:id])
    
    if @comments.destroy
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
