class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


    def index
        @pagy, @posts = pagy(Post.all, items: 2)
    end

    def show
        @post = Post.includes(:author, comments: [:author]).find(params[:id])
        @comments = @post.comments
      end
    
      def new
        if user_signed_in?
          @post = Post.new
        else
          redirect_to new_user_session_path, alert: "You need to sign in to create a new post."
        end
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

      def edit
        @post = Post.find(params[:id])
      end
    
      def update
        @post = Post.find(params[:id])
      
        if @post.update(post_params)
          redirect_to post_path(@post), notice: 'Post updated successfully.'
        else
          render :edit
        end
      end
    
      def destroy
        @post = Post.find(params[:id])
        authorize! :destroy, @post
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
