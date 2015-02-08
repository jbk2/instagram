class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by_name(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post].permit(:name, :description, :image, :tag_names))
    @post.user = current_user
    
    if @post.save
      redirect_to '/posts'
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find_by_name(params[:id])
  end

  def update
    @post = Post.find_by_name(params[:id])

    if @post.update(params[:post].permit(:name, :description))
      redirect_to '/posts'
    else
      render 'new'
    end
  end

  def destroy
    @post = current_user.posts.find_by_name(params[:id])

    @post.destroy
      flash[:notice] = 'Deleted successfully'
    rescue ActiveRecord::RecordNotFound # to be uncommented once users are created. 
      flash[:notice] = "Not your post!"
    ensure
      redirect_to '/posts'
  end

end
