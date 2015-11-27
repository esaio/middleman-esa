require 'middleman-esa/helpers'
require 'middleman-esa/esa_data'

module Middleman
  class EsaExtension < ::Middleman::Extension
    option :paginate, false, 'Whether to paginate lists of articles'
    option :per_page, 10, 'Number of articles per page when paginating'
    option :page_link, 'page/{num}', 'Path to append for additional pages when paginating'
    option :prefix, nil, 'Prefix to mount the esa'

    attr_reader :data

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
