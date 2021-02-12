# Contributing to Ruby To UML

First of all, we'd like to thank you for taking some of your time to contribute to the project. You're awesome 🤠👍

## Table of Contents

- [Getting started](#getting-started)
- [Run the tests](#run-the-tests)
- [Create a package and use it](#create-a-package-and-use-it)
- [Open a PR and add acknowledge your contribution](#open-a-pr-and-add-acknowledge-your-contribution)

## Getting started

> Pre-requisite: you have installed [git][install-git], [ruby][install-ruby] (we recommend using rvm) and [bundler][install-bundler].

1. Clone the repo: `git clone git@github.com:iulspop/ruby_to_uml.git`
1. Go into the cloned repository: `cd ruby_to_uml`
1. Install dependencies: `bundle install`

The project uses [Minitest][minitest] with [Shoulda][shoulda] for the tests and [Rubocop][rubocop] for the formatting.

## Run the tests

You can run unit tests with `bundle exec rake`.

## Create a package and use it

To create a package and install from your local code, run `bundle exec rake install`.

When it's done, run `ruby_to_uml` to use the gem.

This allows you to use the gem before it's published to the RubyGems.

## Open a PR and add acknowledge your contribution

You can open a Pull-Request at any time. It can even be a draft if you need to ask for guidance and help. Actually, we'd be pretty happy to assist you going in the best direction!

Once everything is ready, open a Pull-Request (if it's not already done) and ask for a review. We'll do our best to review it asap.

Finally, [use all-contributors bot command][all-contributors-bot-command] to add yourself to the list of contributors. It's very easy to do, you basically need to mention the bot in a comment of your PR.

Whether it's code, design, typo or documentation, every contribution is welcomed! So again, thank you very, very much 🧙

<!-- Links -->

[install-git]: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
[install-ruby]: https://www.ruby-lang.org/en/documentation/installation/
[install-bundler]: https://bundler.io/
[minitest]: https://github.com/seattlerb/minitest
[rubocop]: https://github.com/rubocop-hq/rubocop
[all-contributors-bot-command]: https://allcontributors.org/docs/en/bot/usage#all-contributors-add
