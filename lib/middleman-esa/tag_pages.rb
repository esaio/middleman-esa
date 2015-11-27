require 'middleman-esa/uri_templates'

module Middleman
  module Esa
    # A sitemap resource manipulator that adds a tag page to the sitemap
    # for each tag in the associated esa
    class TagPages
      include UriTemplates

      def initialize(app, esa_controller)
        @sitemap = app.sitemap
        @esa_controller = esa_controller
        @tag_link_template = uri_template esa_controller.options.taglink
        @tag_template = esa_controller.options.tag_template
        @esa_data = esa_controller.data
      end

      # Get a path to the given tag, based on the :taglink setting.
      # @param [String] tag
      # @return [String]
      def link(tag)
        apply_uri_template @tag_link_template, tag: safe_parameterize(tag)
      end

      # Update the main sitemap resource list
      # @return [void]
      def manipulate_resource_list(resources)
        resources + @esa_data.tags.map do |tag, articles|
          tag_page_resource(tag, articles)
        end
      end

      private

      def tag_page_resource(tag, articles)
        Sitemap::Resource.new(@sitemap, link(tag)).tap do |p|
          p.proxy_to(@tag_template)

          # Add metadata in local variables so it's accessible to
          # later extensions
          p.add_metadata locals: {
            'page_type' => 'tag',
            'tagname' => tag,
            'articles' => articles,
            'esa_controller' => @esa_controller
          }
        end
      end
    end
  end
end
