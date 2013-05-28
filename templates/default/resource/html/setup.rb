def init
  @page_title = "#{object.name.to_s.gsub(/Controller/,"")} - #{options[:title]}"
  sections :header, [:object_details, [:fields_list], T('docstring'), :resource_details, [T('api_details')]]
end

def resource_details
  @meths = (object.children.select{|x| x.has_tag? :url} || [])
  erb(:resource_details)
end

