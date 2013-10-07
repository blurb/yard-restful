require 'fileutils'
require 'open3'

module YARD::Templates::Helpers::HtmlSyntaxHighlightHelper
  # transform a uml code block into a link to the rendered image
  def html_syntax_highlight_uml(code)
    folder = "#{options.serializer.basepath}/diagrams/"
    FileUtils.mkdir_p folder
    filename = Digest::MD5.hexdigest(code) + ".png"
    filepath = folder + filename
    unless File.exists?(filepath)
      plantuml_jar = File.expand_path(File.dirname(__FILE__) + "../../../bin/plantuml.jar")
      cmd = "java -jar " + plantuml_jar + " -p > " + filepath
      IO.popen(cmd, 'r+') do |pipe|
       pipe.write code
      end
    end
    
    <<-EOM
      <img src="diagrams/#{filename}">
    EOM
  end
end

module Blurb
  # create a wrapper around redcarpet to turn on table parsing
  class CustomMarkupProvider
    attr_accessor :provider
    attr_accessor :text

    def initialize(text)
      @text = text

      extensions = { :fenced_code_blocks => true, 
                     :no_intra_emphasis => true, 
                     :tables => true, 
                     :autolink => true
                   }
      renderer = Redcarpet::Render::HTML.new()
      @provider = Redcarpet::Markdown.new(renderer, extensions)
    end

    def to_html
      provider.render(@text)
    end
  end
end

# Prepend Blurb markup provider to list
module YARD
  module Templates::Helpers
    # Helper methods for loading and managing markup types.
    module MarkupHelper
      # remove the normal redcarpet provide and add ours
      MARKUP_PROVIDERS[:markdown].unshift( { :lib => :redcarpet, 
        :const => 'Blurb::CustomMarkupProvider'} )
    end
  end
end

