package Carp::Always::Color::HTML;
use Carp::Always;

=head1 NAME

Carp::Always::Color::HTML - Carp::Always, but with HTML color

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
    eval { Carp::Always::_die(@_) };
    my $err = $@;
    $err =~ s/(.*)/<span style="color:#800">$1<\/span>/;
    die $err;
}

sub _warn {
    my $warning;
    {
        local $SIG{__WARN__} = sub { $warning = $_[0] };
        Carp::Always::_warn(@_);
    }
    $warning =~ s/(.*)/<span style="color:#880">$1<\/span>/;
    warn $warning;
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

=head1 AUTHOR

  Jesse Luehrs <doy at tozt dot net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Jesse Luehrs.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut

1;
