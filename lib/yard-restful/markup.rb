# create a wrapper around redcarpet to turn on table parsing
module Blurb
  class CustomMarkupProvider
    attr_accessor :provider

    def initialize(text)
      self.provider = RedcarpetCompat.new(text,
                           :no_intraemphasis, :gh_blockcode,
                           :tables,:fenced_code, :autolink)
    end

    def to_html
      provider.to_html
    end
  end
end

# Prepend Blurb markup provider to list
module YARD
  module Templates::Helpers
    # Helper methods for loading and managing markup types.
    module MarkupHelper
      MARKUP_PROVIDERS[:markdown].unshift( { :lib => :redcarpet, 
        :const => 'Blurb::CustomMarkupProvider'} )
    end
  end
end