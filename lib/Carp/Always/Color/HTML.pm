package Carp::Always::Color::HTML;
use Carp::Always;

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

1;
