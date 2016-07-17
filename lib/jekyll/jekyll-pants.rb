require 'rubypants'

module Jekyll
  module PantsFilter
    def pants(input)
      RubyPants.new(input, options=[1]).to_html
    end
  end
end

Liquid::Template.register_filter(Jekyll::PantsFilter)
