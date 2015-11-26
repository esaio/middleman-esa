require 'middleman-esa/helpers'

module Middleman
  class EsaExtension < ::Middleman::Extension
    option :paginate, false, 'Whether to paginate lists of articles'
    option :per_page, 10, 'Number of articles per page when paginating'
    option :page_link, 'page/{num}', 'Path to append for additional pages when paginating'


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
      # Do something
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
