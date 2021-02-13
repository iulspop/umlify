# frozen_string_literal: true

$LOAD_PATH << File.expand_path('lib', __dir__)
require 'ruby_to_uml/version'

Gem::Specification.new do |spec|
  spec.name     = 'ruby_to_uml'
  spec.version  = RubyToUML::VERSION

  spec.summary  = 'ruby_to_uml is a tool that creates class diagrams from Ruby code.'
  spec.homepage = 'https://github.com/iulspop/ruby_to_uml'
  spec.metadata = { "source_code_uri" => "https://github.com/iulspop/ruby_to_uml" }
  spec.license  = 'MIT'

  spec.authors  = ['Iuliu Pop']
  spec.email    = ['iuliu.laurentiu.pop@protonmail.com']

  spec.required_ruby_version = '>= 3.0.0'

  spec.add_runtime_dependency('activesupport')
  spec.add_runtime_dependency('ruby_parser')

  spec.executables << 'ruby_to_uml'

  spec.files = %w[
    bin/ruby_to_uml
    lib/ruby_to_uml.rb
    lib/ruby_to_uml/diagram.rb
    lib/ruby_to_uml/parser_sexp.rb
    lib/ruby_to_uml/runner.rb
    lib/ruby_to_uml/uml_class.rb
    lib/ruby_to_uml/version.rb
  ]
end
