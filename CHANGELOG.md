# Changelog

All notable changes to the **Ruby To UML** gem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2021-02-12 - Ruby to UML first release ✨

<details>

### Added

- **[New feature]** Added option to specify directory to create a diagram for all ruby files in project. It works recursively, so reads files from all children directories too. The ability to specify a single file remains.

### Changed

- **(Breaking)** Flag to output diagram link was changed to '--link' and 'l'. Used to be '--html' and '-h'. Also, only outputs link and doesn't save diagram if link mode is enabled.

</details>

## [1.2.6] - 2011-03-14 - Most Recent Umlify version

<details>

- Umlify was forked from here. It supported features like:
  * Guess the types of the instance variables (smart mode)
  * Inheritance
  * Associations (see "How to add associations to a diagram")
  * Mthods and instance variables

</details>

[2.0.0]: https://github.com/iulspop/ruby_to_uml/compare/a9022cb84fbefa54eb2e659ed2f1dd314113b8be...v2.0.0
[1.2.6]: https://github.com/iulspop/ruby_to_uml/commit/a9022cb84fbefa54eb2e659ed2f1dd314113b8be