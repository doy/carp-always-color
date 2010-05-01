package Carp::Always::Color::Term;
use Carp::Always;

=head1 NAME

Carp::Always::Color::Term - Carp::Always, but with terminal color

=head1 SYNOPSIS

  use Carp::Always::Color::Term;

or

  perl -MCarp::Always::Color::Term -e'sub foo { die "foo" } foo()'

=head1 DESCRIPTION

Like L<Carp::Always::Color>, but forces ANSI terminal code coloring, regardless
of where STDERR is pointing to.

=cut

BEGIN { $Carp::Internal{(__PACKAGE__)}++ }

sub _die {
    die @_ if ref($_[0]);
    eval { Carp::Always::_die(@_) };
    my $err = $@;
    $err =~ s/(.*)( at .*? line .*?$)/\e[31m$1\e[m$2/m;
    die $err;
}

sub _warn {
    my @warning;
    {
        local $SIG{__WARN__} = sub { @warning = @_ };
        Carp::Always::_warn(@_);
    }
    $warning[0] =~ s/(.*)( at .*? line .*?$)/\e[33m$1\e[m$2/m;
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

=head1 AUTHOR

  Jesse Luehrs <doy at tozt dot net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Jesse Luehrs.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut

1;
