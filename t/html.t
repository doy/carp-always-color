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
    use Carp::Always::Color::HTML;
    warn "foo";
EOF
    qr+<span style=\"color:#880\">foo</span> at -e line 2\b+,
    "simple warns work");

output_like(<<EOF,
    use Carp::Always::Color::HTML;
    sub foo {
        warn "foo";
    }
    foo();
EOF
    qr+<span style=\"color:#880\">foo</span> at -e line 3\.?\n\tmain::foo\(\) called at -e line 5\n+,
    "warns with a stacktrace work");

output_like(<<EOF,
    use Carp::Always::Color::HTML;
    die "foo";
EOF
    qr+<span style=\"color:#800\">foo</span> at -e line 2\b+,
    "simple dies work");

output_like(<<EOF,
    use Carp::Always::Color::HTML;
    sub foo {
        die "foo";
    }
    foo();
EOF
    qr+<span style=\"color:#800\">foo</span> at -e line 3\.?\n\tmain::foo\(\) called at -e line 5\n+,
    "dies with a stacktrace work");

done_testing;
