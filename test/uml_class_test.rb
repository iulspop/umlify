# frozen_string_literal: true

require 'minitest/autorun'
require 'shoulda'
require 'ruby_to_uml'

class UmlClassTest < Minitest::Test
  context 'UmlClass' do
    setup do
      @class = RubyToUML::UmlClass.new 'Farm'
      @class.variables = %w[ducks some_cows farm_house]
      @class.associations['ducks'] = 'Duck'
    end

    should 'delete variables from the @variables array if they exist in association' do
      @class.finalize_uml_class_info []
      assert_equal false, @class.variables.include?('ducks')
    end

    should 'create a list of children, given all the types available' do
      foo = RubyToUML::UmlClass.new 'Foo'
      foo.parent = 'RubyToUML'

      bar = RubyToUML::UmlClass.new 'Bar'
      bar.parent = 'RubyToUML'

      ruby_to_uml = RubyToUML::UmlClass.new 'RubyToUML'

      classes = [foo, bar, ruby_to_uml]
      classes.each { |c| c.finalize_uml_class_info(classes) }

      assert ruby_to_uml.children.include? foo
      assert ruby_to_uml.children.include? bar
      assert_nil foo.parent
      assert_nil bar.parent
    end

    should 'be able to infer types for associations with the variables in @variables' do
      classes = [RubyToUML::UmlClass.new('Foo'), RubyToUML::UmlClass.new('Bar')]
      foo_bar = RubyToUML::UmlClass.new 'FooBar'
      foo_bar.variables = %w[foo bars args]
      classes << foo_bar

      foo_bar.infer_types! classes

      assert_equal 'Foo', foo_bar.associations['foo']
      assert_equal 'Bar', foo_bar.associations['bars']
      assert_equal '*', foo_bar.associations['bars-n']
      assert_nil foo_bar.associations['args']
    end
  end
end
