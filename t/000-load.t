#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 3;

package Foo;
::use_ok('Carp::Always::Color')
    or ::BAIL_OUT("couldn't load Carp::Always::Color");
::use_ok('Carp::Always::Color::Term')
    or ::BAIL_OUT("couldn't load Carp::Always::Color::Term");
::use_ok('Carp::Always::Color::HTML')
    or ::BAIL_OUT("couldn't load Carp::Always::Color::HTML");
