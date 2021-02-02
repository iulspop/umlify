$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'ruby_to_uml'

runner = RubyToUML::Runner.new ARGV
runner.run
