# frozen_string_literal: true

module RubyToUML
  # Creates and store a yUML api string for generating diagram
  # * type of @statements: 1..* String
  class Diagram
    attr_accessor :statements

    def initialize
      @statements = []
    end

    def create(classes)
      classes.each { |one_class| add(one_class) }
      compute!
      self
    end

    # Adds the given statement to the @diagram array
    # Statement can either be a String or an UmlClass
    def add(statement)
      # TODO: Add some sort of validation

      @statements << statement if statement.is_a? String
      if statement.is_a? UmlClass

        @statements << statement.to_s

        statement.children&.each do |child|
          @statements << "[#{statement.name}]^[#{child.name}]"
        end

        unless statement.associations.empty?
          statement.associations.each do |name, type|
            next if name =~ /-/

            cardinality = (" #{statement.associations["#{name}-n"]}" if statement.associations["#{name}-n"])
            @statements << "[#{statement.name}]-#{name}#{cardinality}>[#{type}]"
          end
        end

      end
    end

    # Sorts the statements array so that
    # 1. Class definitions
    # 2. Inheritance
    # 3. Associations
    # Otherwise, strange behavior can happen in the downloaded graph
    def compute!
      class_def = /^\[[\w;?|=!]*?\]$/
      inheritance = /\[(.*?)\]\^\[(.*?)\]/
      association = /\[.*\]-.*>\[.*\]/

      @statements.sort! do |x, y|
        if x =~ class_def && y =~ inheritance
          -1
        elsif x =~ class_def && y =~ association
          -1
        elsif x =~ inheritance && y =~ association
          -1
        elsif x =~ class_def && y =~ class_def
          0
        elsif x =~ inheritance && y =~ inheritance
          0
        elsif x =~ association && y =~ association
          0
        else
          1
        end
      end
    end

    # returns just the DSL text for diagram
    def get_dsl
      @statements.join(', ')
    end
  end
end
