require 'yard'

class YARD::Handlers::Ruby::RestMethodHandler < YARD::Handlers::Ruby::Legacy::Base
  handles TkDEF

  process do
    puts "hello"
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

    obj = register YARD::CodeObjects::REST::ApiObject.new(nobj, meth)
  end
end

