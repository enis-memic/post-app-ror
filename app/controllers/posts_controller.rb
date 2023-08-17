class PostsController < ApplicationController
    


    def index
        @pagy, @posts = pagy(Post.all, items: 10)
    end

    def show
        @post = Post.includes(:author, comments: [:author]).find(params[:id])
        @comments = @post.comments
      end
    
      def new
        @post = Post.new
      end
    
      def create
        @post = Post.new(post_params)
        @post.author_id = current_user.id
        if @post.save
            redirect_to posts_path, notice: 'New post added successfully.'
        else
          render :new
        end
      end
    
      def destroy
        @post = Post.find(params[:id])
        @post.comments.destroy_all
        if @post.destroy
          redirect_to posts_path(current_user.id)
        else
          render :new
        end
      end
    
      private
    
      def post_params
        params.require(:post).permit(:title, :description)
      end

      def set_user_and_posts
        @user = current_user
        @posts = @user.posts
      end
end
