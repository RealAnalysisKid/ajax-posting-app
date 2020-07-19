class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:create, :destroy]

  def index
    @posts = Post.order("id DESC").limit(20)

    if params[:max_id]
      @posts = @posts.where( "id < ?", params[:max_id] )
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save

    # redirect_to posts_path  因为这样是跳转的新页面 要玩 Ajax 肯定也要砍掉你啦
  end

  def update
    @post = Post.find(params[:id])
    @post.update!( post_params )

    render :json => { :id => @post.id, :message => "ok" }
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

    # redirect_to posts_path  这行会跳转页面 我们需要停留在同一页面
    # render :js => "alert('ok');" 这招叫remote JavaScript 把远端的JS代码抓过来执行 但是在controller里写JS太变态了...
    render :json => { :id => @post.id }
  end

  def like
    @post = Post.find(params[:id])
    unless @post.find_like(current_user)
      Like.create( :user => current_user, :post => @post )
    end

    #redirect_to posts_path
  end

  def unlike
    @post = Post.find(params[:id])
    like = @post.find_like(current_user)
    like.destroy

    # redirect_to posts_path
    render "like"
  end

  def favorite
    @post = Post.find(params[:id])
    unless @post.find_favorite(current_user)
      Favorite.create( :user => current_user, :post => @post )
    end

    # redirect_to posts_path
  end

  def defavorite
    @post = Post.find(params[:id])
    favorite = @post.find_favorite(current_user)
    favorite.destroy

    # redirect_to posts_path
    render "favorite"
  end

  def toggle_flag
    @post = Post.find(params[:id])

    if @post.flag_at
      @post.flag_at = nil
    else
      @post.flag_at = Time.now
    end

    @post.save!

    render :json => { :message => "ok", :flag_at => @post.flag_at, :id => @post.id }
  end

  def rate
    @post = Post.find(params[:id])

    existing_score = @post.find_score(current_user)
    if existing_score
      existing_score.update( :score => params[:score] )
    else
      @post.scores.create( :score => params[:score], :user => current_user )
    end

    render :json => { :average_score => @post.average_score }
  end

  protected

  def post_params
    params.require(:post).permit(:content, :category_id)
  end

end
