YARD::Templates::Engine.register_template_path File.dirname(__FILE__) + '/../templates'

require 'yard-restful/tags'
require 'yard-restful/rest_filters'
require 'yard-restful/html_blocks_helper'

YARD::Templates::Template.extra_includes << RestFilters
YARD::Templates::Template.extra_includes << lambda { |opts| HtmlBlocksHelper if opts.format == :html }
