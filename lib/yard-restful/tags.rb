# Define custom tags
tags = [
  ["Declaration of RESTful API type",:restful_api],
  ["Public API Resource Title",     :topic],
  ["URL",                           :url],
  ["HTTP-Action for the Resource",  :action],

  #["Object Used in Resource",       :resource_object],
  ["Resource Object Property",      :property, :with_types_and_name],
  ["Resource Object Example",       :example],

  ["Overridden method name",        :method_name],

  ["Required Arguments",            :required,          :with_types_and_name],
  ["Optional Arguments",            :optional,          :with_types_and_name],

  ["Example Request",               :example_request],
  ["Example Request Description",   :example_request_description],
  ["Request Fields",                :request_field,     :with_types_and_name],

  ["Example Response",              :example_response],
  ["Example Response Description",  :example_response_description],
  ["Response Fields",               :response_field,    :with_types_and_name],
  ["Response Type",                 :response,    :with_types]
]

tags.each do |tag|
    YARD::Tags::Library.define_tag(*tag)
end
