require 'ruby_parser'

file_content = File.read('test_parser.rb')

s_exp = RubyParser.new.parse(file_content)

# puts s_exp.class.instance_methods(false)

s_exp.each_of_type(:module) do |class_s_exp|
    p class_s_exp
  end

=begin
s(:class, :Car, nil, 
  s(:defn, :initialize, s(:args), 
    s(:iasgn, :@engine, s(:false))
  ),
  s(:call, nil, :private), s(:defn, :activate_engine_systems, s(:args), s(:nil))
)
=end
