$:.push File.expand_path('../lib', __FILE__)
require 'ruby_to_uml/version'

Gem::Specification.new do |spec|
  spec.name = 'ruby_to_uml'
  spec.author = 'Iuliu Pop'
  spec.email = 'iuliu.laurentiu.pop@protonmail.com'
  spec.homepage = 'https://github.com/mikaa123/ruby_to_uml'
  spec.version = RubyToUML::VERSION
  spec.summary = "ruby_to_uml is a tool that creates class diagrams from Ruby code."
  spec.files = %w[
    Rakefile
    README.md
    bin/ruby_to_uml
    lib/ruby_to_uml.rb
    lib/ruby_to_uml/version.rb
    lib/ruby_to_uml/runner.rb
    lib/ruby_to_uml/parser_sexp.rb
    lib/ruby_to_uml/extension.rb
    lib/ruby_to_uml/uml_class.rb
    lib/ruby_to_uml/diagram.rb
    test/diagram_test.rb
    test/uml_class_test.rb
    test/runner_test.rb
    test/string_test.rb
  ]
  spec.test_files = %w[
    test/uml_class_test.rb
    test/parser_sexp_test.rb
    test/diagram_test.rb
    test/runner_test.rb
    test/string_test.rb
  ]
  spec.executables = ['ruby_to_uml']
  spec.add_dependency('ruby_parser')
end
