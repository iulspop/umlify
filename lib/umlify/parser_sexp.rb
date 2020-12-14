# frozen_string_literal: true

require 'ruby_parser'
require 'pathname'

module Umlify
  # Parses files using S-Expressions given by the RubyParser gem
  #
  #  * type of @classes: 0..* UmlClass
  #
  class ParserSexp
    def initialize(path_to_project_folder)
      @folder_path = path_to_project_folder
      @classes = []
    end

    # Parses the source code of the files in @files
    # to build uml classes. Returns an array containing all the
    # parsed classes or nil if no ruby file were found in the
    # @files array.
    def parse_sources!
      files = list_child_files_paths(Pathname.new(@folder_path))
      @source_files = files.select { |f| f.match(/\.rb/) }
      return nil if @source_files.empty?

      @source_files.each do |file|
        puts "processing #{file}..."
        (parse_file File.read(file)).each { |c| @classes << c }
      end

      # Removes duplicates between variables and associations in the class
      @classes.each { |c| c.chomp! @classes }
    end

    # Parse the given string, and return the parsed classes
    def parse_file(file_content)
      classes = []

      s_exp = RubyParser.new.parse(file_content)

      p s_exp

      if s_exp[0] == :class
        classes << parse_class(s_exp)
      else
        s_exp.each_of_type :class do |a_class|
          classes << parse_class(a_class)
        end
      end

      classes
    end

    private

    def list_child_files_paths(path)
      path.children.collect do |child|
        if child.file?
          child
        elsif child.directory?
          list_child_files_paths(child) + [child]
        end
      end.select { |x| x }.flatten(1).map(&:to_s)
    end

    # Creates a UmlClass from a class s-expression
    def parse_class(class_s_exp)
      p class_s_exp
      # Checks if the class is in a module
      uml_class = is_module?(class_s_exp)

      # Let's start by building the associations of the class
      each_association_for class_s_exp do |variable, type, cardinality|
        uml_class.associations[variable] = type
        uml_class.associations["#{variable}-n"] = cardinality if cardinality
      end

      # Searching for a s(:const, :Const) right after the class name, which
      # means the class inherits from a parents class, :Const
      if class_s_exp[2] && (class_s_exp[2][0] == :const)
        classname = recursive_class_name_find class_s_exp[2]
        uml_class.parent = classname unless classname.nil?
      elsif class_s_exp[2] && (class_s_exp[2][0] == :colon2)
        # If the parent class belongs to a module
        classname = recursive_class_name_find class_s_exp[2]
        uml_class.parent = classname unless classname.nil?
      end

      # Looks-up for instance methods
      class_s_exp.each_of_type :defn do |instance_method|
        # Handle question marks in method names
        uml_class.methods << instance_method[1].to_s.gsub(/\?/, '&#63;')

        # Now looking for @variables, inside instance methods
        # I'm looking at assignments such as @var = x
        instance_method.each_of_type :iasgn do |assignment|
          if assignment[1].instance_of?(Symbol) && assignment[1].to_s =~ /@/
            variable = assignment[1].to_s.gsub('@', '')
            uml_class.variables << variable unless uml_class.variables.include? variable
          end
        end
      end
      uml_class
    end

    def is_module?(class_s_exp)
      if class_s_exp[1].instance_of?(Symbol)
        UmlClass.new class_s_exp[1].to_s
      else
        classname = recursive_class_name_find class_s_exp[1]
        UmlClass.new classname unless classname.nil?
      end
    end

    # Yields the variable, the type and the cardinality for each associations
    def each_association_for(a_class)
      if comments = a_class.comments
        comments.split(/\n/).each do |line|
          line.match(/type of @(\w*): ([0-9.*n]* )?([:|\w]*)\b/) do |m|
            yield m[1], m[3], m[2]&.chop
          end
        end
      end
    end

    def recursive_class_name_find(sexp)
      return nil if sexp.nil?
      return sexp[1].to_s if sexp[0] == :const || sexp[0] == :colon3

      classname = recursive_class_name_find sexp[1]
      classname = '' if classname.nil?
      "#{classname}::#{sexp[2]}"
    end
  end
end
