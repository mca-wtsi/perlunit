package Test::Unit::Test;
use strict;

use Carp;
use Test::Unit::Debug qw(debug);

use base qw(Test::Unit::Assert);

sub count_test_cases {
    my $self = shift;
    my $class = ref($self);
    croak "call to abstract method ${class}::count_test_cases";
}

sub run {
    my $self = shift;
    my $class = ref($self);
    croak "call to abstract method ${class}::run";
}

sub name {
    my $self = shift;
    my $class = ref($self);
    croak "call to abstract method ${class}::name";
}

sub to_string {
    my $self = shift;
    return $self->name();
}

sub filter_method {
    my $self = shift;
    my ($token, $method) = @_;

    # Convert hash of arrayrefs from filter() into internally cached hash
    # of hashrefs for faster lookup.
    if (! exists $self->{_filter}{$token}) {
        my @methods = @{ $self->filter->{$token} || [] };
        $self->{_filter}{$token} = { map { $_ => 1 } @methods };
    }

    my $filtered = $self->{_filter}{$token}{$method};
    debug("filter $method by token $token? ",
          $filtered ? 'yes' : 'no',
	  "\n");
    return $filtered;
}

sub filter { {} }

1;
__END__


=head1 NAME

Test::Unit::Test - unit testing framework abstract base class

=head1 SYNOPSIS

This class is not intended to be used directly 

=head1 DESCRIPTION

This class is used by the framework to define the interface of a test.
It is an abstract base class implemented by Test::Unit::TestCase and
Test::Unit::TestSuite.

Due to the nature of the Perl OO implementation, this class is not
really needed, but rather serves as documentation of the interface.

=head1 AUTHOR

Copyright (c) 2000 Christian Lemburg, E<lt>lemburg@acm.orgE<gt>.

All rights reserved. This program is free software; you can
redistribute it and/or modify it under the same terms as Perl itself.

Thanks go to the other PerlUnit framework people: 
Brian Ewins, Cayte Lindner, J.E. Fritz, Zhon Johansen.

=head1 SEE ALSO

=over 4

=item *

L<Test::Unit::Assert>

=item *

L<Test::Unit::TestCase>

=item *

L<Test::Unit::TestSuite>

=back

=cut
