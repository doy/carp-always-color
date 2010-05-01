#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 1;

use Carp::Always::Color;

my $err = bless({}, 'My::Error::Class');
eval { die $err };
is($@, $err, "exception objects aren't affected");
