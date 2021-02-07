require 'minitest/autorun'
require 'shoulda'
require 'ruby_to_uml'

class RunnerTest < Minitest::Test

  context "Runner" do

    should 'be in smart mode when passed -s or --smart as an option'  do
      r = RubyToUML::Runner.new(["-s"])
      r.run
      assert r.smart_mode
      r = RubyToUML::Runner.new(["--smart"])
      r.run
      assert r.smart_mode
    end

    should "print the api url when passed -h or --html option"  do
      r = RubyToUML::Runner.new(["-h"])
      r.run
      assert r.html_mode
      r = RubyToUML::Runner.new(["--html"])
      r.run
      assert r.html_mode
    end
  end
end

