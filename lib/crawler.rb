module Crawler
  # get categories from page
  def get_categories_hash(page)
    page.css('li.badge-section-menu-items a').map {|a| {name: a.content, url: a['href']} }.uniq
  end

  # get articles from page
  def get_articles_hash(page, category_id)
    page.css('articles').map do |a|
      img_url = a.css('div a img').last
      title = a.css('header h2 a').last
      {
          entry_id: a['data-entry-id'].strip.to_s,
          points: a['data-entry-votes'].to_i,
          comments: a['data-entry-comments'].to_i,
          title:title.nil? ? '' : title.content.strip.to_s,
          image_url: img_url.nil? ? '' : img_url['src'].strip.to_s,
          category_id: category_id
      }
    end.uniq
  end

  # create articles
  def create_article(article_hash)
    article = Article.find_or_create_by(entry_id: article_hash[:entry_id])
    article.update_attributes(article_hash)
  end
end