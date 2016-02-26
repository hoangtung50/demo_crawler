class Admin::ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.includes(:category).all

    # Todo add gem 'kaminari' to paginating

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.where(id: params[:id]).last

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.where(id: params[:id]).last
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.where(id: params[:id]).last

   if params[:article].present?
     @article.title = params[:article][:title]
     @article.points = params[:article][:points]

     @article.save!
    end

    # if no error
    respond_to do |format|
      format.html { redirect_to admin_articles_path }
      format.json { head :ok }
    end
  rescue => e
    # if error
    # Todo log here

    flash[:error] = 'Error when update article'

    respond_to do |format|
      format.html { redirect_to action: :edit, id: @article.id }
      format.json { render json: { success: false, message: 'Error when update articles' } }
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.where(id: params[:id]).last
    @article.destroy

    respond_to do |format|
      format.html { redirect_to admin_articles_url }
      format.json { head :ok }
    end
  end
end
