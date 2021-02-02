                            _ _  __
                           | (_)/ _|
            _   _ _ __ ___ | |_| |_ _   _
           | | | | '_ ` _ \| | |  _| | | |
           | |_| | | | | | | | | | | |_| |
            \__,_|_| |_| |_|_|_|_|  \__, |
                                     __/ |
                                    |___/

            umlify is a tool that creates
          uml class diagrams from your code

Introduction
------------

umlify takes your ruby project's source code and creates an uml class diagram out of it.

Installation
------------

    gem install umlify

How to use
----------

1. Go to your gem project directory
2. type: `umlify lib/`
3. Open uml.svg

If you want umlify to try to guess the types of the associations, use
`umlify -s lib/*/*` at step 2.

Example
-------

Here is umlify umlified:

![umlify's uml](TODO)

Features
--------

* Tries to guess the types of the instance variables (smart mode)
* supports inheritiance
* supports associations (see "How to add associations to a diagram")
* supports methods and instance variables

How it works
------------

umlify parses your source codes using regular expressions to build an uml
diagram using [yUML](http://yuml.me/)'s api.

Note: Regexps parsing is really dirty. This point needs serious
improvement

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

If you use umlify with the `-s` or `--smart` option, it'll try to guess
the types of the associations based on the name of the instance
variables.

If you class variable is @duck, then it will try to create an
association with the "Duck" class, if it exists.

If your variable is @ducks, it will try to create an association with a
cardinality of '*' with a class called "Duck", if such a class exists.
