Sequel plugin for Paper Trail
=============

This is a simple Sequel plugin for PaperTrail (with limited functionality).

Conributions are welcome!

[![Gem Version](https://badge.fury.io/rb/sequel_paper_trail.svg)](http://badge.fury.io/rb/sequel_paper_trail)
[![Travis badge](https://travis-ci.org/lazebny/sequel_paper_trail.svg?branch=master)](https://travis-ci.org/lazebny/sequel_paper_trail)
[![Coverage Status](https://coveralls.io/repos/lazebny/sequel_paper_trail/badge.png)](https://coveralls.io/r/lazebny/sequel_paper_trail)
[![Code Climate Badge](https://codeclimate.com/github/lazebny/sequel_paper_trail.svg)](https://codeclimate.com/github/lazebny/sequel_paper_trail)
[![Inch CI](http://inch-ci.org/github/lazebny/sequel_paper_trail.svg)](http://inch-ci.org/github/lazebny/sequel_paper_trail)
[![Dependency Status](https://gemnasium.com/lazebny/sequel_paper_trail.svg)](https://gemnasium.com/lazebny/sequel_paper_trail)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](http://opensource.org/licenses/MIT)

Features
------------

* model are able to subscribe on create, update, delete callback
* can be specified whodunnit
* can be specified info_for_paper_trail
* versioning can be disabled or enabled globaly or in block context

Limitations
------------

* this gem doesn't create a version table
* versions table has a structure as Paper Trail v0.6.x. has
* whodunnit is global
* info_for_paper_trail is global


Installation
------------

Add this line to your application's Gemfile:

```ruby
gem 'sequel_paper_trail'
```

Documentation
-------------


Usage
-------------

Our usage model:

* separate service uses [Sequel](https://github.com/jeremyevans/sequel) + this plugin
* web uses [Paper Trail](https://github.com/airblade/paper_trail) + [Rails Admin](https://github.com/sferik/rails_admin).

Be sure that you have a proper tables from [Paper Trail](https://github.com/airblade/paper_trail) v0.6.x.

Than you can subscribe a model on create, update, destroy callbacks.

Quick start:

```ruby

require 'sequel_paper_trail'
require 'sequel'
require 'sequel/plugins/has_paper_trail'

Album.pligin :has_paper_trail,
             class_name: 'VersionClassName'
# or

Album.pligin :has_paper_trail,
             item_class_name: SomeAlbum,
             class_name: 'VersionClassName'

```

Enable versioning globaly:

```ruby

SequelPaperTrail.enabled = true

```

Enable versioning for block of code:

```ruby

SequelPaperTrail.with_versioning { 'code' }

```

Disable versioning globaly:

```ruby

SequelPaperTrail.enabled = false

```

Disable versioning for block of code

```ruby

SequelPaperTrail.with_versioning(false) { 'code' }

```

Set whodunnit:

```ruby

SequelPaperTrail.whodunnit = 'Mr. Smith'

```

Set info_for_paper_trail - additional info (Hash) which will be attached to versions table.

```ruby

# If you have 'release' and 'instance' columns in a versions table you can populate them.

SequelPaperTrail.info_for_paper_trail = { release: 'asdf131234', instance: `hostname` }

```

Development
--------------

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


Contributing
--------------

This gem has a very limited functionality so conributions are welcome!

Bug reports and pull requests are welcome on GitHub at https://github.com/lazebny/sequel_paper_trail.


License
--------------

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

