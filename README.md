[![Code Climate](https://codeclimate.com/github/allisonlarson/rmmts/badges/gpa.svg)](https://codeclimate.com/github/allisonlarson/rmmts)
[![Test Coverage](https://codeclimate.com/github/allisonlarson/rmmts/badges/coverage.svg)](https://codeclimate.com/github/allisonlarson/rmmts/coverage)
[![Build Status](https://travis-ci.org/allisonlarson/rmmts.svg?branch=master)](https://travis-ci.org/allisonlarson/rmmts)

# RMMTS

RMMTS is an app used for keeping track of how many dollars you and your roommate(s) owe each other.

### How It Works (so far)

Roommate #1 sets up a `Society`, and invites their other roommate to the group. Those roommates will get email invites with links in order to sign up.

Roommate #1 then creates an `Expense`, which will immediately add indivual `Payments` to each `User` in the `Society`. Roommate #1 will also have a credit for how much the other roommate owes them.

Roommates can link their Venmo `Accounts` in app (using the [venmo api](https://developer.venmo.com/docs)), and make payments with the links provided.

Roommate #2 pays their `Payment`, and both the `Expense` and the `Payment` is marked paid. This will reflect in Roommate #2's `payments` section of the `Payment` tab, and Roommate #1's `collections` section of the same tab.

### Coming Up

* Better Account support
* Improved credit handling between groups of more than two people.
* Manually marking payments as paid support
* Make expenses between only a selected number of people in the society
* Improve the frontend look

### How To Help

#### Make Issues

Think of something that might be cool? Think a thing is dumb? Make an issue. Also, check out issues to see what I'm currently working on.

#### Make PRs

Like above, make a PR. All help welcome.


### Running Specs
* Pull down repo
* `bundle install`
* `bundle exec rake`

### Running Locally

* Pull down repo
* `bundle install`
* `bundle exec rails server`
* If you want to do stuff with the venmo api, you'll have to check up their [docs](https://developer.venmo.com/docs) and get your api access stuff set up.
