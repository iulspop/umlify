require 'test/unit'
require 'shoulda'
require 'ruby_to_uml'

class StringTest < Test::Unit::TestCase

  context "String" do

    should "should respond to #classify"  do
      assert_equal "Duck", "ducks".classify
      assert_equal "PepperoniPizza", "pepperoni_pizzas".classify
    end

  end
end

