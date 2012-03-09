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
    use Carp::Always::Color;
    eval { die "foo" };
    if (\$@) {
        die \$@;
    }
EOF
    qr/\e\[31m\e\[31mfoo\e\[m\e\[m at -e line 2\.?\n\teval {\.\.\.} called at -e line 4\b/,
    "rethrowing works");

output_like(<<EOF,
    use Carp::Always::Color;
    sub foo {
        eval { die "foo" };
        if (\$@) {
            die \$@;
        }
    }
    foo();
EOF
    qr/\e\[31m\e\[31mfoo\e\[m\e\[m at -e line 3\.?\n\teval {\.\.\.} called at -e line 3\n\tmain::foo\(\) called at -e line 5\.?\n\tmain::foo\(\) called at -e line 8\n/,
    "rethrowing works inside functions");

done_testing;
