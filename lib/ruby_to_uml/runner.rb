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
      uri = create_yuml_uri(diagram)

      return puts "Link to yUML Diagram: #{uri}" if link_mode
      create_svg_file(uri)
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
      diagram.create do
        classes.each { |c| add c }
      end.compute!
      diagram
    end

    def create_yuml_uri(diagram)
      scheme = 'https://'
      host = 'yuml.me'
      path = "/diagram/boring/class/#{ERB::Util.url_encode(diagram.get_dsl)}"
      uri = URI(scheme + host + path)
    end

    def create_svg_file(uri)
      svg = download_svg(uri)
      save_to_file(svg)
      puts 'Diagram saved in uml.svg'
    end

    def download_svg(uri)
      Net::HTTP.get_response(uri).body
    end

    def save_to_file(svg)
      File.open('uml.svg', 'w') do |file|
        file << svg
      end
    end
  end
end
