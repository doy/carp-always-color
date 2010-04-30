#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 1;

package Foo;
::use_ok('Carp::Always::Color')
    or ::BAIL_OUT("couldn't load Carp::Always::Color");
