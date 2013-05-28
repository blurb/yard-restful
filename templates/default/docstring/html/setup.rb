def init
  return if object.docstring.blank?
  super
#  sections :text
end
