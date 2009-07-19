require 'cucumber/parser/i18n/language'
require 'cucumber/filter'

module Cucumber
  class FeatureFile
    FILE_COLON_LINE_PATTERN = /^([\w\W]*?):([\d:]+)$/
    LANGUAGE_PATTERN = /language:\s*(.*)/

    # The +uri+ argument can ba a path or a path:line1:line2 etc.
    def initialize(uri, source=nil)
      @source = source
      _, @path, @lines = *FILE_COLON_LINE_PATTERN.match(uri)
      if @path
        @lines = @lines.split(':').map { |line| line.to_i }
      else
        @path = uri
      end
    end
    
    # Parses a file and returns a Cucumber::Ast
    # If +options+ contains tags, the result will
    # be filtered.
    def parse(options={})
      filter = Filter.new(@lines, options)
      language = Parser::I18n::Language[lang || options[:lang] || 'en']
      language.parse(source, @path, filter)
    end
    
    def source
      @source ||= if @path =~ /^http/
        require 'open-uri'
        open(@path).read
      else
        File.open(@path, Cucumber.file_mode('r')).read 
      end
    end
    
    def lang
      line_one = source.split(/\n/)[0]
      if line_one =~ LANGUAGE_PATTERN
        $1.strip
      else
        nil
      end
    end
  end
end