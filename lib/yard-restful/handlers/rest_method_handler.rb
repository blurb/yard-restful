require 'yard'

class YARD::Handlers::Ruby::RestMethodHandler < YARD::Handlers::Ruby::Legacy::Base
  handles TkDEF

  attr_accessor :scoped_comments

  process do
    if (namespace.is_a? YARD::Handlers::Ruby::RestClassHandler::RESOURCE_OBJECT)
      nobj = namespace
      mscope = scope

      comments = statement.comments
      restful = !comments.nil? && comments.any? {|comment| comment =~ /@url/ }
      next unless restful

      if statement.tokens.to_s =~ /^def\s+(#{METHODMATCH})(?:(?:\s+|\s*\()(.*)(?:\)\s*$)?)?/m
        meth, args = $1, $2
        meth.gsub!(/\s+/,'')
      else
        raise YARD::Parser::UndocumentableError, "method: invalid name"
      end

      alternates = parse_alternates(meth,statement.comments)

      alternates.keys.each do |alternate|
        self.scoped_comments = alternates[alternate]
        log.debug "registering api: #{alternate} in #{nobj}"
        obj = register YARD::CodeObjects::REST::ApiObject.new(nobj, alternate)
      end
    end
  end

  # split the docstring into groups based on the @alternate tag
  # allows us to document different parameter groups for the same endpoint
  def parse_alternates(base_method_name,comments)
    # by default, there's only one version of the docstring - which maps
    # the base_method_name to the original comments
    alternates = { base_method_name => comments }
    if comments.any? {|comment| comment =~ /@alternate/ }
      alternates = { base_method_name => [] }
      alternate = base_method_name
      comments.each do |comment| 
        if comment =~ /@alternate (\w+)/ 
          alternate = "#{base_method_name}_#{$1}"
          alternates[alternate] = []
        else
          alternates[alternate].push comment
        end
      end
    end
    alternates
  end

  # override so that we can scope the parsed comments 
  def register_docstring(object, docstring = scoped_comments, stmt = statement)
    super
  end

end

