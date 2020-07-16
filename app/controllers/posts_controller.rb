class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:create, :destroy]

  def index
    @posts = Post.order("id DESC").all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save

    # redirect_to posts_path  因为这样是跳转的新页面 要玩 Ajax 肯定也要砍掉你啦
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

    # redirect_to posts_path  这行会跳转页面 我们需要停留在同一页面
    # render :js => "alert('ok');" 这招叫remote JavaScript 把远端的JS代码抓过来执行 但是在controller里写JS太变态了...
  end

  def like
    @post = Post.find(params[:id])
    unless @post.find_like(current_user)
      Like.create( :user => current_user, :post => @post )
    end

    redirect_to posts_path
  end

  def unlike
    @post = Post.find(params[:id])
    like = @post.find_like(current_user)
    like.destroy

    redirect_to posts_path
  end

  protected

  def post_params
    params.require(:post).permit(:content)
  end

end
