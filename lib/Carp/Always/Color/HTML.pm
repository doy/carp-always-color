package Carp::Always::Color::HTML;
use strict;
use warnings;
use Carp::Always;
# ABSTRACT: Carp::Always, but with HTML color

=head1 SYNOPSIS

  use Carp::Always::Color::HTML;

or

  perl -MCarp::Always::Color::HTML -e'sub foo { die "foo" } foo()'

=head1 DESCRIPTION

Like L<Carp::Always::Color>, but forces HTML coloring, regardless of where
STDERR is pointing to.

=cut

BEGIN { $Carp::Internal{(__PACKAGE__)}++ }

sub _die {
    die @_ if ref($_[0]);
    eval { Carp::Always::_die(@_) };
    my $err = $@;
    $err =~ s/(.*)( at .*? line .*?$)/<span style="color:#800">$1<\/span>$2/m;
    die $err;
}

sub _warn {
    my @warning;
    {
        local $SIG{__WARN__} = sub { @warning = @_ };
        Carp::Always::_warn(@_);
    }
    $warning[0] =~ s/(.*)( at .*? line .*?$)/<span style="color:#880">$1<\/span>$2/m;
    warn @warning;
}

my %OLD_SIG;
BEGIN {
    @OLD_SIG{qw(__DIE__ __WARN__)} = @SIG{qw(__DIE__ __WARN__)};
    $SIG{__DIE__} = \&_die;
    $SIG{__WARN__} = \&_warn;
}

END {
    @SIG{qw(__DIE__ __WARN__)} = @OLD_SIG{qw(__DIE__ __WARN__)};
}

1;
