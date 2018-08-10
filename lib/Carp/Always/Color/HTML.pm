package Carp::Always::Color::HTML;
use strict;
use warnings;
use Carp::Always 0.15 ();
BEGIN { our @ISA = qw(Carp::Always) }
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

sub _colormess {
    my ( $msg, $css ) = @_;
    $msg =~ s/(.*)( at .*? line .*?$)/<span style="$css">$1<\/span>$2/m;
    $msg;
}

sub _die {
    die @_ if ref $_[0];
    die _colormess( &Carp::Always::_longmess, 'color:#800' );
}

sub _warn {
    warn _colormess( &Carp::Always::_longmess, 'color:#880' );
}

1;
