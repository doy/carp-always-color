package Carp::Always::Color;
use strict;
use warnings;
# ABSTRACT: Carp::Always, but with color

use if (-t *STDERR), 'Carp::Always::Color::Term';

=head1 SYNOPSIS

  use Carp::Always::Color;

or

  perl -MCarp::Always::Color -e'sub foo { die "foo" } foo()'

=head1 DESCRIPTION

Stack traces are hard to read when the messages wrap, because it's hard to tell
when one message ends and the next message starts. This just colors the first
line of each stacktrace, based on whether it's a warning or an error. If
messages are being sent to a terminal, it colors them with terminal escape
codes. If you want to force this behavior, you can use
L<Carp::Always::Color::Term> instead, which will always add terminal escape
codes, even when the messages are being sent to something that doesn't look
like a terminal. L<Carp::Always::Color::HTML> also exists, to add HTML color
markup to the messages instead of terminal color codes.

=head1 BUGS

No known bugs.

Please report any bugs through RT: email
C<bug-carp-always-color at rt.cpan.org>, or browse to
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Carp-Always-Color>.

=head1 SEE ALSO

L<Carp::Always>

=head1 SUPPORT

You can find this documentation for this module with the perldoc command.

    perldoc Carp::Always::Color

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Carp-Always-Color>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Carp-Always-Color>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Carp-Always-Color>

=item * Search CPAN

L<http://search.cpan.org/dist/Carp-Always-Color>

=back

=cut

1;
