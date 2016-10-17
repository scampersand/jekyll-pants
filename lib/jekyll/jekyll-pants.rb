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

      args = []
      if config.include?('options')
        args.push(config['options'])
      elsif config.include?('entities')
        args.push([2])  # default in RubyPants
      end
      if config.include?('entities')
        args.push(config['entities'])
      end

      RubyPants.new(input, *args).to_html
    end
  end
end

Liquid::Template.register_filter(Jekyll::PantsFilter)
