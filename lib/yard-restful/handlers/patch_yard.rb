require 'yard'

# force load of base.rb
YARD::CodeObjects::Base

# When trying to match a method name, YARD tries to find a namespace followed by a method name
# if a method name is capitalized, it causes YARD to do a ton of backtracking (since the 
# CONSTANTMATCH greedily matches the name of the method, and then slowy backs off)
# By adding a \b to the CONSTANTMATCH regex, it reduces the amount of backtracking needed

module YARD
  module CodeObjects
    # add word break to minimize backtracking
    CONSTANTMATCH = /[A-Z]\w*\b/

    # re-evaluate these so they get the definition above
    NAMESPACEMATCH = /(?:(?:#{NSEPQ}\s*)?#{CONSTANTMATCH})+/
    METHODMATCH = /(?:(?:#{NAMESPACEMATCH}|[a-z]\w*)\s*(?:#{CSEPQ}|#{NSEPQ})\s*)?#{METHODNAMEMATCH}/
  end
end
