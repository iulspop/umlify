# frozen_string_literal: true

require 'minitest/autorun'
require 'shoulda'
require 'ruby_to_uml'

class DiagramTest < Minitest::Test
  Diagram = RubyToUML::Diagram

  context 'Diagram' do
    should 'add Strings statements to diagram' do
      test_statement = '[foo]->[bar]'
      diagram = Diagram.new([test_statement])

      assert_equal ['[foo]->[bar]'], diagram.statements
    end

    should 'add UmlClass without associations to diagrams' do
      test_uml_class = RubyToUML::UmlClass.new 'Unicorn'
      test_uml_class.variables << 'foo_variable'
      test_uml_class.methods << 'bar_method'

      diagram = Diagram.new([test_uml_class])

      assert diagram.statements.include? '[Unicorn|foo_variable|bar_method]'
    end

    should 'add UmlClass with associations to diagrams' do
      test_uml_class = RubyToUML::UmlClass.new 'Unicorn'
      test_uml_class.variables << 'foo_variable'
      test_uml_class.methods << 'bar_method'
      test_uml_class.associations['foo'] = 'Bar'
      test_uml_class.associations['chunky'] = 'Bacon'

      diagram = Diagram.new([test_uml_class])

      assert diagram.statements.include? '[Unicorn|foo_variable|bar_method]'
      assert diagram.statements.include? '[Unicorn]-foo>[Bar]'
      assert diagram.statements.include? '[Unicorn]-chunky>[Bacon]'
    end

    should 'process cardinality for associations' do
      test_uml_class = RubyToUML::UmlClass.new 'Unicorn'
      test_uml_class.associations['foo'] = 'Bar'
      test_uml_class.associations['foo-n'] = '1..*'

      diagram = Diagram.new([test_uml_class])

      assert diagram.statements.include? '[Unicorn]-foo 1..*>[Bar]'
    end

    # should "add UmlClass with parent to diagrams"  do
    #   test_uml_class = RubyToUML::UmlClass.new 'Unicorn'
    #   test_uml_class.variables << 'foo_variable'
    #   test_uml_class.methods << 'bar_method'
    #   test_uml_class.parent = "Foo"

    #   diagram = Diagram.new do
    #     add test_uml_class
    #   end

    #   assert diagram.statements.include? '[Unicorn|foo_variable|bar_method]'
    #   assert diagram.statements.include? '[Foo]^[Unicorn]'
    # end

    should "sort the statements so that the class declarations are first, then
        the inheritance, then the associations" do
      statements= ['[Foo]^[Unicorn]', '[Unicorn]-foo 1..*>[Bar]', '[Unicorn|foo_variable|bar_method]']
      diagram = Diagram.new(statements)
      assert_equal ['[Unicorn|foo_variable|bar_method]', '[Foo]^[Unicorn]', '[Unicorn]-foo 1..*>[Bar]'],
                   diagram.statements
    end
  end
end
