require 'middleman-esa/helpers'
require 'middleman-esa/esa_data'

module Middleman
  class EsaExtension < ::Middleman::Extension
    option :paginate, false, 'Whether to paginate lists of articles'
    option :per_page, 10, 'Number of articles per page when paginating'
    option :page_link, 'page/{num}', 'Path to append for additional pages when paginating'
    option :prefix, nil, 'Prefix to mount the esa'
    option :layout, 'layout', 'Article-specific layout'
    option :taglink, 'tags/{tag}.html', 'Path tag pages are generated at.'
    option :tag_template, nil, 'Template path (no template extension) for tag archive pages.'

    attr_reader :data
    attr_reader :tag_pages

    self.defined_helpers = [Middleman::Esa::Helpers]

    def initialize(app, options_hash={}, &block)
      # Call super to build options from the options_hash
      super

      # Require libraries only when activated
      # require 'necessary/library'

      # set up your extension
      # puts options.my_option
      puts "Middleman::EsaExtension initialized"
    end

    def after_configuration
      @app.esa_instance = self
      @data = Esa::EsaData.new(@app, self, options)

      @app.sitemap.register_resource_list_manipulator(:esa_articles, @data, false)

      if options.tag_template
        @app.ignore options.tag_template

        require 'middleman-esa/tag_pages'
        @tag_pages = Esa::TagPages.new(@app, self)
        @app.sitemap.register_resource_list_manipulator(:esa_tags, @tag_pages, false)
      end
    end

    # A Sitemap Manipulator
    # def manipulate_resource_list(resources)
    # end

    # module do
    #   def a_helper
    #   end
    # end
  end
end
