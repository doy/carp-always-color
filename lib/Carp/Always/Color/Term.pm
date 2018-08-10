package Carp::Always::Color::Term;
use strict;
use warnings;
use Carp::Always 0.15 ();
BEGIN { our @ISA = qw(Carp::Always) }
# ABSTRACT: Carp::Always, but with terminal color

=head1 SYNOPSIS

  use Carp::Always::Color::Term;

or

  perl -MCarp::Always::Color::Term -e'sub foo { die "foo" } foo()'

=head1 DESCRIPTION

Like L<Carp::Always::Color>, but forces ANSI terminal code coloring, regardless
of where STDERR is pointing to.

=cut

BEGIN { $Carp::Internal{(__PACKAGE__)}++ }

sub _colormess {
    my ( $msg, $esc ) = @_;
    $msg =~ s/(.*)( at .*? line .*?$)/$esc$1\e[m$2/m;
    $msg;
}

sub _die {
    die @_ if ref $_[0];
    die _colormess( &Carp::Always::_longmess, "\e[31m" );
}

sub _warn {
    warn _colormess( &Carp::Always::_longmess, "\e[33m" );
}

1;
