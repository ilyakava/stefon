# Stefon

[![Build Status](https://travis-ci.org/ilyakava/stefon.png?branch=master)](https://travis-ci.org/ilyakava/stefon)

Get tips on who to ask for a code review, runs on Ruby 1.9.2 and above.

### Looks like:

![stefon cmd line action](http://f.cl.ly/items/2E1r332W0c3j2O3d2W2z/stefon_hi.gif)

This preview features my local changes in the [pre-commit gem](https://github.com/jish/pre-commit).

### Mascot

A name inspired by the SNL character Bill Hader played:

![stefon on wikipedia](http://upload.wikimedia.org/wikipedia/en/c/c1/Stefon%2C_SNL_Character.jpg)

SNL Stefon always gave advice on the best places to go to in the city. Stefon the gem will do the same: he tells you who to go to for a code review (or send a PR to) based on whose code you changed most.

## Installation

Add this line to your application's Gemfile:

    gem 'stefon'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stefon

## Usage
Execute:

    $ stefon

To get the top 4 people to send a code review to.

You can use the -l option to change the number of people Stefon's recommendations are limited to:
Execute:

    $ stefon --limit 42

To get the top 42 people to ask for a code review (identical to `stefon -l 42` ).

To get a detailed report of code that you changed, execute:

    $ stefon --full-report
which is identical to `stefon -f`, to see something like:

    $ stefon -f
    Finished in 0.592418 seconds
    Added 1 line to files written by: Cindy Sherman
    Deleted 2 lines written by: Cindy Sherman
    Added 1 line to files written by: Ed Ruscha
    Deleted 1 line written by: Ed Ruscha
    Deleted 1 file written by: Ed Ruscha
    Deleted 1 line written by: Gerhard Richter
    The top commiter in this repo is: Van Gogh


## Todos / Comming improvements
* use Github API to get a list of contributors for a project (and filter suggestions)
* loading user preferences (list of users to exclude) - maybe with dotfiles instead of yml files
* handle errors from surveryors
* remove dependency of Grit class on Git module
* exclude authors from
    * the grit module - file top author
    * the git module - repo top commiter


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### The narrative of stefon's code

Stefon lives in the shell. We ask for suggestions by interacting with the `CLI` (using the trollop gem for getting cmd line options), the `CLI` gets an `Editor` to write a script for Stefon. The `Editor` has a team of `Surveyors` that look for certain changes in the codebase (`AddedLines`, `DeletedFiles`, etc.). To detect these changes, the `Surveyors` use `GitUtils` (a wrapper for cmd line git interface) and `GritUtils` (a wrapper for another gem called grit), and store scores in a `SurveyorStor`, which acts like a `Hash`. The `Editor` is responsible for assembling the team, telling them how detailed of a report he needs (`--full-report` option) and for how many users (--limit option), and combinning their reports, so that the `CLI` can print it out on the screen.
