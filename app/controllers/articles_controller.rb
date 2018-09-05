class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]

  #GET /articles

  def index
    @articles = current_user.articles
    json_response(@articles)
  end

  #POST /articles
  def create
    @article = current_user.articles.create!(article_params)
    json_response(@article, :created)
  end

  #GET /articles/:id
  def show
    json_response(@article)
  end

  #PUT /articles/:id
  def update
    @article.update(article_params)
    head :no_content
  end

  #DELETE /articles/:id
  def destroy
    @article.destroy
    head :no_content
  end

  private

  def article_params
    params.permit(:title, :post)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
