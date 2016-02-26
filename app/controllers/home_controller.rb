class HomeController < ApplicationController
  # show all articles
  def index
    # get 10 articles last to show index
    @articles = Article.last(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # Todo show articles for category
  def category
    @category = Category.where(id: params[:id]).last
    @articles = @category.nil? ? [] : @category.articles
  end

  # Todo show article
  def show
    @article = Article.where(id: params[:id]).last
  end
end
