# 🖼️ Ruby To UML Class Diagram

Ruby To UML takes creates a uml class diagram from ruby source code.

![][uml_diagram_demo]

Installation
------------

    gem install ruby_to_uml

How to use
----------

1. Go to your Ruby project directory

2. Run ruby_to_um
    * To create diagram for a whole project: `ruby_to_uml lib/`
    * To create diagram for one file: `ruby_to_uml lib/thing.rb`
    * Optionally, you can pass in the '-s' option to ruby_to_uml for it decuce associations between classes

3. Open uml.svg with any browser

Features
--------

* Tries to guess the types of the instance variables (smart mode)
* supports inheritiance
* supports associations (see "How to add associations to a diagram")
* supports methods and instance variables

How it works
------------

ruby_to_uml uses ruby_parser to parse Ruby source code to an S-expression tree. Then, the S-expression is parsed into UML classes. Finally, the UML classes are convert to a DSL and sent to [yUML](http://yuml.me/)'s API for conversion into a diagram.

On dynamic languages
--------------------

Ruby's extreme decoupling and duck-typing philosophy doesn't judge a class by its hierarchy.
Thus, variables don't have a predefined type, which conflicts with uml's static typed object-model.
The objective of this project isn't to bend uml's model to make it semantically comply with
duck typing (by the use of interfaces, or other tricks), but to add a basic visual representation
of the code of your project for documenting and helping maintainers.

How to add associations to a diagram
------------------------------------

Because of the above point, there's no direct way to automatically draw associations between your
classes. However, if you want an association to be shown on your diagram simply annotate your classes such as:

    # type of @weapon: Rainbow
    class Unicorn

      def initialize weapon
        @weapon = weapon
      end
    end

Smart mode
----------

If you use ruby_to_uml with the `-s` or `--smart` option, it'll try to guess
the types of the associations based on the name of the instance
variables.

If you class variable is @duck, then it will try to create an
association with the "Duck" class, if it exists.

If your variable is @ducks, it will try to create an association with a
cardinality of '*' with a class called "Duck", if such a class exists.

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

Alternatives
------------

This gem is a fork of [umlify](https://github.com/mikaa123/umlify), which doesn't function at the time of writing.

Thanks to Michael Sokol for creating Umlify and allowing me to republish it!

<!-- Links -->

[uml_diagram_demo]: https://github.com/iulspop/ruby_to_uml/blob/master/docs/UML_diagram_demo.svg?raw=true