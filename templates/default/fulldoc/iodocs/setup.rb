# This is an instance of YARD::Templates::Engine::Template__

include Helpers::ModuleHelper
include Helpers::FilterHelper

def init
  title = options[:title] || "myapidefinition"
  @objects = select_restful(@objects)
  options[:serializer].serialize("#{title}.json", erb(:apiconfig))
end
