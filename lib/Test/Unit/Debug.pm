package Test::Unit::Debug;

=head1 NAME

Test::Unit::Debug - framework debugging control (internal)

=head1 SYNOPSIS

    package MyRunner;

    use Test::Unit::Debug qw(debug_to_file debug_pkg);

    debug_to_file('foo.log');
    debug_pkg('Test::Unit::TestCase');

=head1 DESCRIPTION

You may ignore this package if you are not debugging the internals of
Test::Unit.

You may also use it as a place to store & query a per-package debug
flag for your own packages, but there are probably interfaces for
doing that.

Broadly, it allows control of the destination of debugging; control
over which packages make debug noise; and L</debug> to emit noise.

It offers several subroutines via L<Exporter>.  It is not part of the
inheritance tree.

=cut

use strict;

use base 'Exporter';
use vars qw(@EXPORT_OK);
@EXPORT_OK = qw(debug debug_to_file
                debug_pkg no_debug_pkg debug_pkgs no_debug_pkgs debugged);

my %DEBUG = (); # key = package name, value = boolean
my $out = \*STDERR;


=head1 EXPORTABLE ROUTINES

These are all subroutines (don't call them as methods).

=head2 debug_to_file($file)

Switch debugging to C<$file>.

=cut

sub debug_to_file {
    my ($file) = @_;
    open(DEBUG, ">$file") or die "Couldn't open $file for writing: $!";
    $out = \*DEBUG;
}


=head2 debug_to_stderr()

Switch debugging to STDERR (this is the default).

=cut

sub debug_to_stderr {
    $out = \*STDERR;
}


=head2 debug(@message)

Send the debug message to the current destination iff the calling
package has debug messages enabled via L</debug_pkg>.  C<@message> is
printed using the prevailing C<$,> .

Note that the arguments must be evaluated and the subroutine call made
every time, even when debugging is off.  Therefore don't perform slow
operations without also making them conditional, nor use it in tight
loops.

=cut

sub debug {
    my ($package, $filename, $line) = caller();
    print $out @_ if $DEBUG{$package};
}


=head2 debug_pkg(@pkg)

Enable debugging in one or more packages C<@pkg>.

=cut

sub debug_pkg {
    $DEBUG{$_} = 1 foreach @_;
}

# Deprecated.  debug_pkg now does the same.
sub debug_pkgs {
    $DEBUG{$_} = 1 foreach @_;
    warn "DEPRECATED: debug_pkgs";
}


=head2 no_debug_pkg(@pkg)

Disable debugging in one or more packages C<@pkg>.  This is the
default for all packages.

=cut

sub no_debug_pkg {
    $DEBUG{$_} = 0 foreach @_;
}

# Deprecated.  no_debug_pkg now does the same.
sub no_debug_pkgs {
    $DEBUG{$_} = 0 foreach @_;
    warn "DEPRECATED: no_debug_pkgs";
}


=head2 debugged($pkg)

Return true iff the package has debugging enabled.

=head2 debugged()

Return true iff the B<calling> package has debugging enabled.

=cut

sub debugged {
    my ($package, $filename, $line) = caller();
    return $DEBUG{$_[0] || $package};
}


=head1 AUTHOR

Copyright (c) 2000-2002, 2005 the PerlUnit Development Team
(see L<Test::Unit> or the F<AUTHORS> file included in this
distribution).

All rights reserved. This program is free software; you can
redistribute it and/or modify it under the same terms as Perl itself.

=cut

1;
