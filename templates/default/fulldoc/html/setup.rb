include Helpers::ModuleHelper
include Helpers::FilterHelper


def init
  super

  serialize_object_type :resource

  asset("css/rest_custom.css", file("css/rest_custom.css", true))
end

#
# Generate pages for the objects if there are objects of this type contained
# within the Registry.
#
def serialize_object_type(type)
  objects = Registry.all(type.to_sym)
  Array(objects).each {|object| serialize(object) }
end

#
# @note This method overrides YARD's default template class_list method.
#
# The existing YARD 'Class List' search field contains all the YARD namespace objects.
# We, however, do not want the Rest namespace objects
#
# This method removes the namespace from the root node, generates the class list,
# and then adds it back into the root node.
#
def class_list(root = Registry.root)
  return super unless root == Registry.root

  resource_namespace = YARD::CodeObjects::REST::RESOURCES_NAMESPACE
  object_namespace = YARD::CodeObjects::REST::OBJECTS_NAMESPACE
  root.instance_eval { children.delete resource_namespace }
  root.instance_eval { children.delete object_namespace }
  out = super(root)
  root.instance_eval { children.push resource_namespace }
  root.instance_eval { children.push object_namespace }
  out
end

def generate_object_list
  @items = Registry.at(:objects).children
  @list_title = "List of Objects"
  @list_type = "object"
  asset('object_list.html', erb(:full_list))
end

def generate_resource_list
  @items = Registry.at(:resources).children
  @list_title = "List of Resources"
  @list_type = "resource"
  @list_class = "class"

  asset('resource_list.html', erb(:full_list))
 end
