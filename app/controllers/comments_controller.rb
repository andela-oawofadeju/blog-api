class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [:show, :update, :destroy]

  #GET /articles/:article_id/comments/:id

  def index
    json_response(@article.comments)
  end

  #GET /articles/:article_id/comments/:id
  def show
    json_response(@comment)
  end

  #POST /articles/:article_id/comments/:id
  def create
    @article.comments.create!(comment_params)
    json_response(@article, :created)
  end

  #PUT /articles/:article_id/comments/:id
  def update
    @comment.update(comment_params)
    head :no_content
  end

  #DELETE /articles/:article_id/comments/:id
  def destroy
    @comment.destroy
    head :no_content
  end

  private
  
  def comment_params
    params.permit(:name, content)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = Comment.find_by!(id: params[:id]) if @article
  end
end
