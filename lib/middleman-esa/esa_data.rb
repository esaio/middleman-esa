# require 'middleman-esa/uri_templates'

module Middleman
  module Esa
    class EsaData

      attr_reader :source_template
      attr_reader :options
      attr_reader :controller

      # @private
      def initialize(app, controller, options)
        @app        = app
        @controller = controller
        @options    = options

        # A list of resources corresponding to Esa articles
        @_articles = []
      end

      # A list of all Esa articles, sorted by descending date
      # @return [Array<Middleman::Sitemap::Resource>]
      def articles
        @_articles.sort_by(&:date).reverse
      end

      # Updates' Esa articles destination paths to be the
      # permalink.
      # @return [void]
      def manipulate_resource_list(resources)
        @_articles = []
        resources.each do |resource|
          article = convert_to_article(resource)
          @_articles << article
          used_resources << resource
        end
      end

      def inspect
        "#<Middleman::Esa::EsaData: #{articles.inspect}>"
      end

      private

      def convert_to_article(resource)
        return resource if resource.is_a?(EsaArticle)

        resource.extend EsaArticle
        resource.esa_controller = controller

        resource
      end
    end
  end
end
