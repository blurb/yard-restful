include Helpers::FilterHelper

def init
  super
end

def stylesheets
   super + %w(css/rest_custom.css)
end

def menu_lists
  super + 
  [
    { :type => 'resource', :title => "Resources", :search_title => "Resources" },
    { :type => 'object', :title => "Objects", :search_title => "Objects" }
  ]
end

