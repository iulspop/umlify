# frozen_string_literal: true

require 'optparse'
require 'net/http'
require 'erb'

module RubyToUML
  # Run an instance of RubyToUML program. Only intended for internal use.
  class Runner
    attr_reader :smart_mode, :html_mode

    def initialize(args)
      return puts 'Usage: ruby_to_uml [source directory]' if args.empty?

      @args = args
      @smart_mode = false
      parse_options
    end

    def run
      classes = parse_s_expressions
      return puts 'No ruby files in the directory.' unless classes

      classes.each { |c| c.infer_types! classes } if smart_mode

      diagram = create_diagram(classes)

      create_svg_file(diagram)
    end

    private

    attr_reader :args
    attr_writer :smart_mode

    def parse_options
      OptionParser.new do |opts|
        opts.on('-s', '--smart') { smart_mode = true }
        opts.on('-v', '--version') { puts VERSION }
      end.parse!(args)
    end

    def parse_s_expressions
      ParserSexp.new(args[0]).parse_sources!
    end

    def create_diagram(classes)
      diagram = Diagram.new
      diagram.create do
        classes.each { |c| add c }
      end.compute!
      diagram
    end

    def create_svg_file(diagram)
      svg = download_svg(diagram)
      save_to_file(svg)
      puts 'Saved in uml.svg'
    end

    def download_svg(diagram)
      scheme = 'https://'
      host = 'yuml.me'
      path = "/diagram/scruffy/class/#{ERB::Util.url_encode(diagram.get_dsl)}"
      uri = URI(scheme + host + path)
      Net::HTTP.get_response(uri).body
    end

    def save_to_file(svg)
      File.open('uml.svg', 'w') do |file|
        file << svg
      end
    end
  end
end
