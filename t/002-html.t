#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
BEGIN {
    eval "use IO::Pty::Easy;";
    plan skip_all => "IO::Pty::Easy is required for this test" if $@;
    plan tests => 4;
}

sub output_is {
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    my ($script, $expected, $desc) = @_;
    my $pty = IO::Pty::Easy->new;
    $pty->spawn("$^X", "-e", $script);
    is($pty->read, $expected, $desc);
}

output_is(<<EOF,
    use Carp::Always::Color::HTML;
    warn "foo";
EOF
    "<span style=\"color:#880\">foo at -e line 2</span>\n",
    "simple warns work");

output_is(<<EOF,
    use Carp::Always::Color::HTML;
    sub foo {
        warn "foo";
    }
    foo();
EOF
    "<span style=\"color:#880\">foo at -e line 3</span>\n\tmain::foo() called at -e line 5\n",
    "warns with a stacktrace work");

output_is(<<EOF,
    use Carp::Always::Color::HTML;
    die "foo";
EOF
    "<span style=\"color:#800\">foo at -e line 2</span>\n",
    "simple dies work");

output_is(<<EOF,
    use Carp::Always::Color::HTML;
    sub foo {
        die "foo";
    }
    foo();
EOF
    "<span style=\"color:#800\">foo at -e line 3</span>\n\tmain::foo() called at -e line 5\n",
    "dies with a stacktrace work");
