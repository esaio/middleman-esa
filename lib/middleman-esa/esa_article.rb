require 'active_support/time_with_zone'
require 'active_support/core_ext/time/acts_like'
require 'active_support/core_ext/time/calculations'

module Middleman
  module Esa
    module EsaArticle
      def self.extended(base)
        base.class.send(:attr_accessor, :esa_controller)
      end

      def esa_data
        esa_controller.data
      end

      def esa_options
        esa_controller.options
      end

      def render(opts={}, locs={}, &block)
        if opts[:layout].nil?
          opts[:layout] = metadata[:options][:layout]
          opts[:layout] = esa_options.layout if opts[:layout].nil?
          # Convert to a string unless it's a boolean
          opts[:layout] = opts[:layout].to_s if opts[:layout].is_a? Symbol
        end

        content = super(opts, locs, &block)
      end

      # The title of the article, set from frontmatter.
      # @return [String]
      def title
        data["title"]
      end

      # A list of tags for this article, set from frontmatter.
      # @return [Array<String>] (never +nil+)
      def tags
        article_tags = data["tags"]

        if article_tags.is_a? String
          article_tags.split(',').map(&:strip)
        else
          Array(article_tags).map(&:to_s)
        end
      end

      # Attempt to figure out the date of the post. The date should be
      # present in the source path, but users may also provide a date
      # in the frontmatter in order to provide a time of day for sorting
      # reasons.
      #
      # @return [TimeWithZone]
      def date
        return @_date if @_date

        frontmatter_date = data['date'] || data['updated_at'] || data['created_at']

        # First get the date from frontmatter
        if frontmatter_date.is_a? Time
          @_date = frontmatter_date.in_time_zone
        else
          @_date = Time.zone.parse(frontmatter_date.to_s)
        end
      end

      # The previous (chronologically earlier) article before this one
      # or +nil+ if this is the first article.
      # @return [esaArticle]
      def previous_article
        esa_data.articles.find { |a| a.date < self.date }
      end

      # The next (chronologically later) article after this one
      # or +nil+ if this is the most recent article.
      # @return [Middleman::Sitemap::Resource]
      def next_article
        esa_data.articles.reverse.find { |a| a.date > self.date }
      end

      def body
        render layout: false
      end

      # This is here to prevent out-of-memory on exceptions.
      # @private
      def inspect
        "#<Middleman::esa::esaArticle: #{data.inspect}>"
      end
    end
  end
end
