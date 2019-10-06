class Api::V1::CommentsController < ApplicationController
  before_action :authorize_request, only:[:create]
  before_action :set_blog, only:[:create]
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /comments
  def index
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    puts comment_params
    @comment = Comment.new({user_id:@current_user.id,blog_id:comment_params[:blog_id],content:comment_params[:content]})

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Comment not found' }, status: :not_found
    end

    def set_blog
      comments = Comment.where("user_id = ? AND created_at<= ? OR  created_at>=?  ", @current_user.id,Time.now, (Time.now - 24.hours)).select("blog_id")
      blog= Blog.where(id: comments.map(&:blog_id))
      if blog.count >=2
        render json:{message:"you already commented to 2 blogs in 24H"}, status: :not_acceptable
      end
    rescue ActiveRecord::RecordNotFound
      begin
      render json: { errors: 'Blog not found' }, status: :not_found
      end
    end

    
    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:user_id, :blog_id, :content)
    end
end
