#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
BEGIN {
    eval "use IO::Pty::Easy;";
    plan skip_all => "IO::Pty::Easy is required for this test" if $@;
    plan tests => 5;
}

sub output_is {
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    my ($script, $expected, $desc) = @_;
    my $pty = IO::Pty::Easy->new;
    $pty->spawn("$^X", "-e", $script);
    is($pty->read, $expected, $desc);
}

output_is(<<EOF,
    use Carp::Always::Color::Term;
    warn "foo";
EOF
    "\e[33mfoo\e[m at -e line 2\n",
    "simple warns work");

output_is(<<EOF,
    use Carp::Always::Color::Term;
    sub foo {
        warn "foo";
    }
    foo();
EOF
    "\e[33mfoo\e[m at -e line 3\n\tmain::foo() called at -e line 5\n",
    "warns with a stacktrace work");

output_is(<<EOF,
    use Carp::Always::Color::Term;
    die "foo";
EOF
    "\e[31mfoo\e[m at -e line 2\n",
    "simple dies work");

output_is(<<EOF,
    use Carp::Always::Color::Term;
    sub foo {
        die "foo";
    }
    foo();
EOF
    "\e[31mfoo\e[m at -e line 3\n\tmain::foo() called at -e line 5\n",
    "dies with a stacktrace work");

{ local $TODO = "this is a Carp::Always bug";
output_is(<<EOF,
    use Carp::Always::Color::Term;
    die "foo at bar line 23";
EOF
    "\e[31mfoo at bar line 23\e[m at -e line 2\n",
    "weird messages work");
}
