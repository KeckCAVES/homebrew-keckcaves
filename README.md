# Overview

This repository contains formula for KeckCAVES Vrui-based software.

# Using

These formula can be installed via the raw GitHub URLs, or by cloning this repository locally and installing off the local disk.

*NOTE: You must first install Vrui via the vrui.rb formula before installing anything else.*  This is because Homebrew does not yet handle dependency tracking for external repositories.

## Using Raw URLs

First you need to get your hands on the raw URL. For example, the raw url for the vrui formula is:

`https://github.com/keckcaves/homebrew/raw/master/vrui.rb`

Pass that URL as a parameter to the `brew install` command, like so:

`brew install https://github.com/keckcaves/homebrew/raw/master/vrui.rb`

## Cloning the Repository

Clone the repository to somewhere that you'll remember:

`git clone https://github.com/keckcaves/homebrew.git /usr/local/LibraryKeckCAVES`

This example creates a `LibraryKeckCAVES` directory under `/usr/local`.

Then to install a formula pass the full path to the formula into the `brew install` command. Here's another example that installs vrui:

`brew install /usr/local/LibraryKeckCAVES/keckcaves.rb`
