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

      comments = statement.comments
      restful = !comments.nil? && comments.any? {|comment| comment =~ /@restful/ }
      return unless restful

      if classname =~ /(#{CONSTANTMATCH})$/
        # strip out namespaces
        classname = $1

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
end

class YARD::Handlers::Ruby::Legacy::MethodHandler < YARD::Handlers::Ruby::Legacy::Base

  process do
    # don't register a normal method handler inside of a resource
    unless (namespace.is_a? YARD::Handlers::Ruby::RestClassHandler::RESOURCE_OBJECT)
      super
    end
  end
end