# Api get articles for mobile
class Api::ArticlesController < Api::BaseController

  # /api/articles/get_all
  def index
    json_response = {status: 202, body: nil}

    begin

      # Todo authenticate
      if false #request.headers["X-ULTI-SIGNATURE"].blank?
        json_response = {status: 401, body: ["Missing request header 'X-ULTI-SIGNATURE'."]}
      elsif false #!valid_signature?
        Rails.logger.error { "message: Invalid signature. With signature: '#{request.headers["X-ULTI-SIGNATURE"]}', request body: '#{request.body.read}'" }
        json_response = {status: 401, body: ["Invalid signature."]}
      else
        @articles = Article.includes(:category).all
        json_response = {status: 202, body: {articles: @articles}}

      end
    rescue Exception => e
      json_response = {status: 500}
      json_response[:messages] = ['Exception: ' + e.message]

      Rails.logger.error('Exception: ' + e.message)
      Rails.logger.error('backtrace: ' + e.backtrace.join("\n"))
    end

    render :json => json_response[:body], status:  json_response[:status]

  end

  # articles/category/1
  def category
    json_response = {status: 202, body: nil}

    begin

      # Todo authenticate
      if false #request.headers["X-ULTI-SIGNATURE"].blank?
        json_response = {status: 401, body: ["Missing request header 'X-ULTI-SIGNATURE'."]}
      elsif false #!valid_signature?
        Rails.logger.error { "message: Invalid signature. With signature: '#{request.headers["X-ULTI-SIGNATURE"]}', request body: '#{request.body.read}'" }
        json_response = {status: 401, body: ["Invalid signature."]}
      else
        @category = Category.where(id: params[:id]).last
        @articles = @category.nil? ? [] : @category.articles
        json_response = {status: 202, body: {category: @category, articles: @articles}}

      end
    rescue Exception => e
      json_response = {status: 500}
      json_response[:messages] = ['Exception: ' + e.message]

      Rails.logger.error('Exception: ' + e.message)
      Rails.logger.error('backtrace: ' + e.backtrace.join("\n"))
    end

    render :json => json_response[:body], status:  json_response[:status]

  end
end