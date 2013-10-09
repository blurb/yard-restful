require 'fileutils'
require 'open3'

module YARD::Templates::Helpers::HtmlSyntaxHighlightHelper
  # transform a uml code block into a link to the rendered image
  def html_syntax_highlight_uml(code)
    root = options.adapter ? options.adapter.document_root : options.serializer.basepath
    if root && root.size > 0 && !root.end_with?('/')
      root = root + "/"
    end
    folder = "#{root}diagrams/"
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
    if options.adapter
      url = url_for_file(filepath)
    else
      url = "diagrams/#{filename}"
    end
    
    <<-EOM
      <img src="#{url}">
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
      # remove the normal redcarpet provider and add ours
      MARKUP_PROVIDERS[:markdown].unshift( { :lib => :redcarpet, 
        :const => 'Blurb::CustomMarkupProvider'} )
    end
  end
end

