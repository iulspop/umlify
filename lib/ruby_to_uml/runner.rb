# frozen_string_literal: true

require 'optparse'
require 'net/http'
require 'erb'

module RubyToUML
  class Runner
    def initialize(args)
      abort('Usage: ruby_to_uml [source directory]') if args.empty?

      @args = args
      @smart_mode = false
      @link_mode = false

      parse_options
    end

    def run
      classes = parse_s_expressions
      abort('No ruby files in the directory.') unless classes
      classes.each { |c| c.infer_types! classes } if smart_mode

      diagram = create_diagram(classes)

      if link_mode
        uri = yuml_uri(diagram)
        puts "Link to yUML Diagram: #{uri}"
      else
        png = download_diagram(yuml_uri(diagram, type: '.png'))
        save_file(png, type: '.png')
        puts 'Diagram saved in uml.png'
      end
    end

    private

    attr_reader :args
    attr_accessor :smart_mode, :link_mode

    def parse_options
      OptionParser.new do |opts|
        opts.on('-s', '--smart') { self.smart_mode = true }
        opts.on('-l', '--link')  { self.link_mode = true }
        opts.on('-v', '--version') { puts VERSION }
      end.parse!(args)
    end

    def parse_s_expressions
      path = args[0]
      ParserSexp.new(path).parse_sources!
    end

    def create_diagram(classes)
      diagram = Diagram.new
      diagram.create(classes)
    end

    def yuml_uri(diagram, type: '')
      scheme = 'https://'
      host = 'yuml.me'
      path = "/diagram/boring/class/#{ERB::Util.url_encode(diagram.get_dsl)}"
      uri = URI(scheme + host + path + type)
    end

    def download_diagram(uri)
      Net::HTTP.get_response(uri).body
    end

    def save_file(data, type: '')
      File.open("uml#{type}", 'w') do |file|
        file << data
      end
    end
  end
end
