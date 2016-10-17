require 'kramdown/parser'

module Kramdown
  module Parser
    class Pantsdown < Kramdown::Parser::Kramdown
      def initialize(source, options)
        super
        @span_parsers -= [:smart_quotes, :typographic_syms]
      end
    end
  end
end
