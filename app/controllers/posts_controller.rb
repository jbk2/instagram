class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post].permit(:name, :description, :image))
    @post.user = current_user
    
    if @post.save
      redirect_to '/posts'
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(params[:post].permit(:name, :description))
      redirect_to '/posts'
    else
      render 'new'
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])

    @post.destroy
      flash[:notice] = 'Deleted successfully'
    rescue ActiveRecord::RecordNotFound # to be uncommented once users are created. 
      flash[:notice] = "Not your post!"
    ensure
      redirect_to '/posts'
  end

end
