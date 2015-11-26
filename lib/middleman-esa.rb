# Require core library
require 'middleman-core'

::Middleman::Extensions.register(:esa) do
  require "middleman-esa/extension"
  ::Middleman::EsaExtension
end
