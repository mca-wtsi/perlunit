package Test::Unit::TestSuite;
use strict;
use constant DEBUG => 0;
use base qw(Test::Unit::Test);

use Test::Unit::TestCase;
use Test::Unit::InnerClass;

# helper subroutines

# determine if a string is the name of a class

sub is_not_name_of_a_class {
    # assume it is a class if we can load it
    # don't know any better, if you do, please tell me
    my $name = shift;
    return 1 if $name =~ /\s+/; # can't be an classname?
    eval "require $name";
    print $@ if DEBUG;
    return 1 if $@;
}

sub is_a_test_case_class {
    my $pkg = shift;
    return 0 if is_not_name_of_a_class($pkg);
    no strict 'refs';
    if ("$pkg"->isa("Test::Unit::TestCase")) {
	return 1;
    }
    return 0;
}

# get list of all parent classes of a class

sub flatten_inheritance_tree {
    # finally a place to put my scheme heritage to work
    my ($pkg, %seen) = @_;
    my @parents;
    return if $seen{$pkg};
    $seen{$pkg}++;	
    no strict 'refs';
    for my $p (@{$pkg . "::ISA"}) {
	push @parents, $p;
	push @parents, flatten_inheritance_tree($p, %seen);
    }
    return @parents;
}

# class and object methods

sub new {
    my $class = shift;
    my ($classname) = @_;
    
    my @_Tests = ();
    my $self = {
	_Tests => \@_Tests,
	_Name => $classname,
	_Names => [],
    };
    bless $self, $class;
    print ref($self) . "::new($classname) called\n" if DEBUG;
    
    if (is_not_name_of_a_class($classname)) {
	die "Could not find class $classname";
    } else {
	# it is a class, create a suite with its tests
	# ... and that of its ancestors, if they are Test::Unit::TestCase
	no strict 'refs';
	if (not is_a_test_case_class($classname)) {
	    my $message = "Class " . $classname . 
		" is not a Test::Unit::TestCase";
	    $self->add_test($self->warning($message));
	    return $self;
	}
	my @packages_to_search = ($classname, 
				  flatten_inheritance_tree($classname));
	for my $pkg (@packages_to_search) {
	    next unless is_a_test_case_class($pkg);
	    my @candidates = grep /^test/, keys %{$pkg . "::"};
	    for my $c (@candidates) {
		if (defined(&{$pkg . "::" . $c})) {
		    my $method = $pkg . "::" . $c;
		    $self->add_test_method($method, $self->names());
		}
	    }
	}
	if (not @{$self->tests()}) {
	    $self->add_test($self->warning("No tests found in $classname"));
	}
    }

    return $self;
}

sub empty_new {
    my $class = shift;
    my ($name) = @_;
    
    my @_Tests = ();
    my $self = {
	_Tests => \@_Tests,
	_Name => $name,
	_Names => [],
    };
    bless $self, $class;

    print ref($self), "::empty_new($name) called\n" if DEBUG;
    return $self;
}

sub name {
    my $self = shift;
    return $self->{_Name};
}

sub names {
    my $self = shift;
    return $self->{_Names};
}

sub add_test {
    my $self = shift;
    my ($test) = @_;
    push @{$self->tests()}, $test;
}

sub add_test_method {
    my $self = shift;
    my ($test_method, $names) = @_;
    my ($class, $method) = ($test_method =~ m/^(.*)::(.*)$/);
    return if grep /^\Q$method\E$/, @{$names}; 
    no strict 'refs';
    push @{$self->names()}, $method;
    my $a_test_case_sub_class_instance = "$class"->new($method);
    unless ($a_test_case_sub_class_instance) {
	$self->add_test($self->warning("add_test_method: Could not call $class"."::"."new()"));
	return;
    }
    push @{$self->tests()}, $a_test_case_sub_class_instance;
}
 
sub count_test_cases {
    my $self = shift;
    my $count = 0;
    for my $e (@{$self->tests()}) {
	$count += $e->count_test_cases();
    }
    return $count;
}

sub run {
    my $self = shift;
    my ($result) = @_;
    for my $e (@{$self->tests()}) {
	last if $result->should_stop();
	$e->run($result);
    }
	return $result;
}
    
sub test_at {
    my $self = shift;
    my ($index) = @_;
    return $self->tests()->[$index];
}

sub test_count {
    my $self = shift;
    return scalar @{$self->tests()};
}

sub tests {
    my $self = shift;
    return $self->{_Tests};
}

sub to_string {
    my $self = shift;
    return $self->name();
}

sub warning {
    my $self = shift;
    my ($message) = @_;
    return Test::Unit::InnerClass::make_inner_class("Test::Unit::TestCase", <<"EOIC", "warning");
sub run_test {
    my \$self = shift;
    \$self->fail('$message');
}
EOIC
}

1;
__END__


=head1 NAME

Test::Unit::TestSuite - unit testing framework base class

=head1 SYNOPSIS

    use Test::Unit::TestSuite;

    # more code here ...

    sub suite {
	my $class = shift;

	# create an empty suite
	my $suite = Test::Unit::TestSuite->empty_new("A Test Suite");
	
	# get and add an existing suite
	$suite->add_test(Test::Unit::TestSuite->new("MyModule::Suite_1"));

	# extract suite by way of suite method and add
	$suite->add_test(MyModule::Suite_2->suite());
	
	# get and add another existing suite
	$suite->add_test(Test::Unit::TestSuite->new("MyModule::TestCase_2"));

	# return the suite built
	return $suite;
    }

=head1 DESCRIPTION

This class is normally not used directly, but it can be used for
creating your own custom built aggregate suites.

Normally, this class just provides the functionality of auto-building
a test suite by extracting methods with a name prefix of C<test> from
a given package to the test runners.

=head1 AUTHOR

Framework JUnit authored by Kent Beck and Erich Gamma.

Ported from Java to Perl by Christian Lemburg.

Copyright (c) 2000 Christian Lemburg, E<lt>lemburg@acm.orgE<gt>.

All rights reserved. This program is free software; you can
redistribute it and/or modify it under the same terms as Perl itself.

Thanks go to the other PerlUnit framework people: 
Brian Ewins, Cayte Lindner, J.E. Fritz, Zhon Johansen.

=head1 SEE ALSO

=over 4

=item *

L<Test::Unit::TestRunner>

=item *

L<Test::Unit::TkTestRunner>

=item *

For further examples, take a look at the framework self test
collection (Test::Unit::tests::AllTests).

=back

=cut
