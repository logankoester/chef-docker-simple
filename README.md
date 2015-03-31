# docker-simple cookbook
> Install Docker and related software.

[![Build Status](http://ci.ldk.io/logankoester/chef-docker-simple/badge)](http://ci.ldk.io/logankoester/chef-docker-simple/)
[![Gittip](http://img.shields.io/gittip/logankoester.png)](https://www.gittip.com/logankoester/)

## Installation

Using [Berkshelf](http://berkshelf.com/), add the `docker-simple` cookbook to your Berksfile.

```ruby
cookbook 'docker-simple', github: 'logankoester/chef-docker-simple', branch: 'master'
```
Then run `berks` to install it.

## Usage

* `docker-simple::default` will simply install Docker.
* `docker-simple::compose` will install Docker Compose.

### docker-simple::default

Include `docker-simple` in your run_list.

```json
{
  "run_list": [
    "recipe[docker-simple::default]"
  ]
}
```
#
## Running the tests

This cookbook uses the [Foodcritic](http://www.foodcritic.io/) linter, [ChefSpec](http://sethvargo.github.io/chefspec/) for unit testing, and [ServerSpec](http://serverspec.org/) for integration testing via [Test Kitchen](http://kitchen.ci/) with the [kitchen-docker](https://github.com/portertech/kitchen-docker) driver.

It's not as complicated as it sounds, but you will need to have Docker installed.

1. `git clone git@github.com:logankoester/chef-docker-simple.git`
2. `cd chef-docker-simple`
3. `bundle install`
4. `bundle exec rake`

This will run all of the tests once. While developing, run `bundle exec guard start` and the relevant tests will run automatically when you save a file.

## Author

Copyright (c) 2015 [Logan Koester](http://logankoester.com). Released under the MIT license. See `LICENSE` for details.
