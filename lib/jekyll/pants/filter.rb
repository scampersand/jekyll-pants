require 'jekyll'
require 'rubypants'

module Jekyll
  module PantsFilter
    def pants(input)
      config = @context.registers[:site].config['pants'] || {}

      if config.include?('entities') && ! config.include?('options')
        Jekyll.logger.warn <<EOF
Found pants.entities in config; you should also add pants.options
since they're positional arguments to RubyPants.new
EOF
      end

      # Ideally don't populate args to avoid overriding RubyPants defaults.
      # Unfortunately if entities is provided, then options must also be
      # provided since they're positional parameters.
      args = []

      if config.include?('options')
        args.push(config['options'].map {|o| o.to_sym rescue o})
      elsif config.include?('entities')
        args.push([2])  # default in RubyPants
      end

      if config.include?('entities')
        args.push(Jekyll::Utils.symbolize_hash_keys(config['entities']))
      end

      RubyPants.new(input, *args).to_html
    end
  end
end

Liquid::Template.register_filter(Jekyll::PantsFilter)
