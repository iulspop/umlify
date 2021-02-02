# frozen_string_literal: true

require 'optparse'
require 'net/http'
require 'erb'

module Umlify
  # Run an instance of Umlify program. Only intended for internal use.
  class Runner
    attr_reader :smart_mode, :html_mode

    # Takes as input an array with file names
    def initialize(args)
      @args = args
      @smart_mode = false
      @html_mode = false
    end

    # Runs the application
    def run
      parse_options

      if @args.empty?
        puts 'Usage: umlify [source directory]'
      else
        parser_sexp = ParserSexp.new @args[0]

        if classes = parser_sexp.parse_sources!
          diagram = Diagram.new

          classes.each { |c| c.infer_types! classes } if @smart_mode

          diagram.create do
            classes.each { |c| add c }
          end.compute!

          # puts diagram.statements.join("\n")
          image = download_image(diagram)
          # save_to_file(image)
          # puts "Saved in uml.png."
        else
          puts 'No ruby files in the directory.'
        end
      end
    end

    def parse_options
      OptionParser.new do |opts|
        opts.on('-s', '--smart') { @smart_mode = true }
        opts.on('-h', '--html') { @html_mode = true }
        opts.on('-v', '--version') { puts VERSION }
      end.parse! @args
    end

    def download_image(diagram)
      scheme = "https://"
      host = "yuml.me"
      path = "/diagram/scruffy/class/" + ERB::Util.url_encode(diagram.get_dsl)
      uri = URI(scheme + host + path)
      Net::HTTP.get(uri)
    end

    # def save_to_file image
    #   File.open('uml.png', 'wb') do |file|
    #     file << image.body
    #   end
    # end
  end
end
