#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
BEGIN {
    eval "use IO::Pty::Easy;";
    plan skip_all => "IO::Pty::Easy is required for this test" if $@;
}

sub output_like {
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    my ($script, $expected, $desc) = @_;
    my $pty = IO::Pty::Easy->new;
    $pty->spawn("$^X", "-e", $script);
    like($pty->read, $expected, $desc);
}

output_like(<<EOF,
    use Carp::Always::Color::Term;
    warn "foo";
EOF
    qr/\e\[33mfoo\e\[m at -e line 2\b/,
    "simple warns work");

output_like(<<EOF,
    use Carp::Always::Color::Term;
    sub foo {
        warn "foo";
    }
    foo();
EOF
    qr/\e\[33mfoo\e\[m at -e line 3\.?\n\tmain::foo\(\) called at -e line 5\n/,
    "warns with a stacktrace work");

output_like(<<EOF,
    use Carp::Always::Color::Term;
    die "foo";
EOF
    qr/\e\[31mfoo\e\[m at -e line 2\b/,
    "simple dies work");

output_like(<<EOF,
    use Carp::Always::Color::Term;
    sub foo {
        die "foo";
    }
    foo();
EOF
    qr/\e\[31mfoo\e\[m at -e line 3\.?\n\tmain::foo\(\) called at -e line 5\n/,
    "dies with a stacktrace work");

output_like(<<EOF,
    use Carp::Always::Color::Term;
    die "foo at bar line 23";
EOF
    qr/\e\[31mfoo at bar line 23\e\[m at -e line 2\b/,
    "weird messages work");

done_testing;
