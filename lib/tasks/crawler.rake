require 'nokogiri'
require 'open-uri'
require "#{Rails.root}/lib/crawler.rb"
include Crawler

task :crawler => :environment do
  begin
    page = Nokogiri::HTML(open('http://9gag.com'))

    # get categories hash
    categories_hash = get_categories_hash(page)

    categories_hash.each do |cate|

      category = Category.find_or_create_by(name: cate[:name])

      page = Nokogiri::HTML(open(cate[:url]))

      # get articles hash for category url
      articles_hash = get_articles_hash(page, category.id)

      articles_hash.each { |article_hash| create_article(article_hash)}

    end # done: categories_hash.each
  rescue Exception => e
    # if error
    # Todo log here
    puts e.message
  end
end



