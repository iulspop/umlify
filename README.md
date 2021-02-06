# 🖼️ Ruby To UML Class Diagram
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-4-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

Ruby To UML takes creates a uml class diagram from ruby source code.

![][uml_diagram_demo]

## Installation

    gem install ruby_to_uml

## How to use

1. Go to your Ruby project directory

2. Run ruby_to_um
    * To create diagram for a whole project: `ruby_to_uml lib/`
    * To create diagram for one file: `ruby_to_uml lib/thing.rb`
    * Optionally, you can pass in the '-s' option to ruby_to_uml for it decuce associations between classes

3. Open uml.svg with any browser

## Features

* Tries to guess the types of the instance variables (smart mode)
* supports inheritiance
* supports associations (see "How to add associations to a diagram")
* supports methods and instance variables

## How it works

ruby_to_uml uses ruby_parser to parse Ruby source code to an S-expression tree. Then, the S-expression is parsed into UML classes. Finally, the UML classes are convert to a DSL and sent to [yUML](http://yuml.me/)'s API for conversion into a diagram.

## On dynamic languages

Ruby's extreme decoupling and duck-typing philosophy doesn't judge a class by its hierarchy.
Thus, variables don't have a predefined type, which conflicts with uml's static typed object-model.
The objective of this project isn't to bend uml's model to make it semantically comply with
duck typing (by the use of interfaces, or other tricks), but to add a basic visual representation
of the code of your project for documenting and helping maintainers.

## How to add associations to a diagram

Because of the above point, there's no direct way to automatically draw associations between your
classes. However, if you want an association to be shown on your diagram simply annotate your classes such as:

    # type of @weapon: Rainbow
    class Unicorn

      def initialize weapon
        @weapon = weapon
      end
    end

## Smart mode

If you use ruby_to_uml with the `-s` or `--smart` option, it'll try to guess
the types of the associations based on the name of the instance
variables.

If you class variable is @duck, then it will try to create an
association with the "Duck" class, if it exists.

If your variable is @ducks, it will try to create an association with a
cardinality of '*' with a class called "Duck", if such a class exists.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/mikaa123"><img src="https://avatars.githubusercontent.com/u/428280?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Michael Sokol</b></sub></a><br /><a href="#infra-mikaa123" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/iulspop/ruby_to_uml/commits?author=mikaa123" title="Tests">⚠️</a> <a href="https://github.com/iulspop/ruby_to_uml/commits?author=mikaa123" title="Code">💻</a></td>
    <td align="center"><a href="http://treewalker.wordpress.com"><img src="https://avatars.githubusercontent.com/u/38147?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Tyler Green</b></sub></a><br /><a href="https://github.com/iulspop/ruby_to_uml/commits?author=tylergreen" title="Code">💻</a></td>
    <td align="center"><a href="http://tobinharris.com"><img src="https://avatars.githubusercontent.com/u/25578?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Tobin Harris</b></sub></a><br /><a href="https://github.com/iulspop/ruby_to_uml/commits?author=tobinharris" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/iulspop"><img src="https://avatars.githubusercontent.com/u/53665722?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Iuliu Pop</b></sub></a><br /><a href="https://github.com/iulspop/ruby_to_uml/commits?author=iulspop" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

## Why fork Umlify?

This gem is a fork of [umlify](https://github.com/mikaa123/umlify).
That project is no longer maintained, but the code is good and solves a problem.

This project fixes breaking issues with umlify. We also plan to add new features, such as showing private/public methods.

Thanks to Michael Sokol and contributors for creating Umlify and allowing me to republish it!

## Licence

💁 [Copyright 2011 Michael Sokol][license]


<!-- Links -->

[license]: https://github.com/iulspop/ruby_to_uml/blob/master/LICENSE.md

<!-- Demo images -->

[uml_diagram_demo]: https://github.com/iulspop/ruby_to_uml/blob/master/docs/UML_diagram_demo.svg?raw=true
