class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user
  before_action :find_post, only: [:edit, :update]

  def index
    @posts = Post.all
  end

  def new
  end

  def create
    user_id = current_user.id

    Post.create(
      content: params[:post][:content],
      user_id: user_id
    )

    redirect_to user_path(id: user_id)
  end

  def edit
  end

    def update

      @post = Post.find(params[:id])
       if current_user.admin? || current_user.vip?
         @post.update_attributes(post_params)
         redirect_to posts_path
       else
         return head(:forbidden) unless @post.user_id == current_user.id
         @post.update_attributes(post_params)
         redirect_to posts_path
       end
     end


  private

  def authorization!
    raise "You are not authorized to view this page, please sign in" unless current_user

    unless current_user == @post.user || current_user.vip? || current_user.admin?
      redirect_to post_path(id: @post.id), :alert => "You do not have access rights"
    end
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def find_user
    current_user
  end


end
