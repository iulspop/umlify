$:.push File.expand_path('../lib', __FILE__)
require 'umlify/version'

Gem::Specification.new do |spec|
  spec.name = 'umlify'
  spec.author = 'Michael Sokol'
  spec.email = 'mikaa123@gmail.com'
  spec.homepage = 'https://github.com/mikaa123/umlify'
  spec.version = Umlify::VERSION
  spec.summary = "umlify is a tool that creates class diagrams from your code."
  spec.files = %w[
    Rakefile
    README.md
    bin/umlify
    lib/umlify.rb
    lib/umlify/version.rb
    lib/umlify/runner.rb
    lib/umlify/parser_sexp.rb
    lib/umlify/extension.rb
    lib/umlify/uml_class.rb
    lib/umlify/diagram.rb
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
  spec.executables = ['umlify']
  spec.add_dependency('ruby_parser')
  spec.add_dependency('activesupport')
end
