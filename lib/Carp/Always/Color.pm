package Carp::Always::Color;
use strict;
use warnings;
# ABSTRACT: Carp::Always, but with color

BEGIN {
    if (-t *STDERR) {
        require Carp::Always::Color::Term;
    }
    else {
        require Carp::Always::Color::HTML;
    }
}

=head1 SYNOPSIS

  use Carp::Always::Color;

or

  perl -MCarp::Always::Color -e'sub foo { die "foo" } foo()'

=head1 DESCRIPTION

Stack traces are hard to read when the messages wrap, because it's hard to tell
when one message ends and the next message starts. This just colors the first
line of each stacktrace, based on whether it's a warning or an error. If
messages are being sent to a terminal, it colors them with terminal escape
codes, otherwise it colors them with HTML (ideas for more intelligent behavior
here are welcome).

=head1 SEE ALSO

L<Carp::Always>

=cut

1;
