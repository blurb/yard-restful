module YARD::CodeObjects::REST
  
  class NamespaceObject < YARD::CodeObjects::NamespaceObject
    def inheritance_tree(include_mods = false)
       [self]
    end
  end

  class Resources < NamespaceObject ; end
  class Objects < NamespaceObject ; end


  RESOURCES_NAMESPACE = Resources.new(:root, "resources") unless defined?(RESOURCES_NAMESPACE)

  OBJECTS_NAMESPACE = Objects.new(:root, "objects") unless defined?(OBJECTS_NAMESPACE)
   
end