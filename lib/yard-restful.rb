YARD::Templates::Engine.register_template_path File.dirname(__FILE__) + '/../templates'
require 'redcarpet'

require 'yard-restful/handlers/patch_yard.rb'

require 'yard-restful/tags'
require 'yard-restful/rest_filters'
require 'yard-restful/html_blocks_helper'
require 'yard-restful/markup.rb'
require 'yard-restful/code_objects/namespace_object.rb'
require 'yard-restful/code_objects/api_object.rb'
require 'yard-restful/code_objects/resource_object.rb'
require 'yard-restful/handlers/rest_class_handler.rb'
require 'yard-restful/handlers/rest_method_handler.rb'

YARD::Templates::Template.extra_includes << RestFilters
YARD::Templates::Template.extra_includes << lambda { |opts| HtmlBlocksHelper if opts.format == :html }
