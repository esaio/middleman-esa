require 'middleman-esa/helpers'

module Middleman
  module Esa
    # Blog-related helpers that are available to the Middleman application in +config.rb+ and in templates.
    module Helpers
      def paginate
        false
      end
    end
  end
end
