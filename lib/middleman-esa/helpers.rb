require 'middleman-esa/helpers'
require 'middleman-esa/esa_article'

module Middleman
  module Esa
    module Helpers
      def paginate
        false
      end

      def esa
        esa_controller.data
      end

      def esa_instance
        @esa_instance
      end

      def esa_instance=(instance)
        @esa_instance = instance
      end

      def page_articles
        meta = current_resource.metadata
        limit = meta[:page]["per_page"]

        # "articles" local variable is populated by Calendar and Tag page generators
        # If it's not set then use the complete list of articles
        articles = meta[:locals]["articles"] || esa_controller.data.articles

        limit ? articles.first(limit) : articles
      end

      def esa_controller
        esa_instance
      end

      def current_article
        article = current_resource
        return nil unless article
        return nil unless article.is_a?(EsaArticle)
        article
      end
    end
  end
end
