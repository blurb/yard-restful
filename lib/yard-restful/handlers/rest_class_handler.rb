require 'yard'

class YARD::Handlers::Ruby::RestClassHandler < YARD::Handlers::Ruby::Legacy::Base
  handles TkCLASS
  namespace_only

  RESOURCE_OBJECT = YARD::CodeObjects::REST::ResourceObject
  RESOURCES_NAMESPACE = YARD::CodeObjects::REST::RESOURCES_NAMESPACE
  OBJECTS_NAMESPACE = YARD::CodeObjects::REST::OBJECTS_NAMESPACE

  process do
    if statement.tokens.to_s =~ /^class\s+(#{NAMESPACEMATCH})\s*(?:<\s*(.+)|\Z)/m
      classname = $1
      superclass_def = $2
      classname = classname.gsub(/\s/, '')

      restful = statement.comments.any? {|comment| comment =~ /@restful/ }
      return unless restful

      if classname =~ /Controller$/
        namespace = RESOURCES_NAMESPACE
      else
        namespace = OBJECTS_NAMESPACE
      end

      klass = register RESOURCE_OBJECT.new(namespace, classname)
      parse_block(:namespace => klass)
    end
  end
end