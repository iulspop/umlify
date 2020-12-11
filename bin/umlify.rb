$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'umlify'

runner = Umlify::Runner.new ARGV
runner.run
