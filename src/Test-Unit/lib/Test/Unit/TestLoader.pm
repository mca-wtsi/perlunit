package Test::Unit::TestLoader;
use strict;
use FileHandle;
use constant DEBUG => 1;

use Test::Unit::TestSuite;
use Test::Unit::TestCase;
use Test::Unit::UnitHarness;

# should really do something in here about a local @INC.
sub load {
  my $test_case=shift;
  my $suite;
  # Is it a test class?
  print "About to load $test_case\n" if DEBUG;
  if ($test_case=~/^[\w:]+$/ and eval "require $test_case") {
	print "Eval succeeded.\n" if DEBUG;
	# first up: is this a real test case?
	$suite=try_test_case($test_case);
	return $suite if ($suite);
	$suite=try_test_suite($test_case);
	return $suite if ($suite);
  } else {
	print "Debug: ".$@ if DEBUG;
  }
  for my $file ("$test_case",
			  "$test_case.t",
			  "t/$test_case",
			  "t/$test_case.t" ) {
	# try it out as a test::harness type test.
	$suite=try_test_harness($file);
	return $suite if $suite;
  }
  # one last shot: is it a _directory_?
  $suite=try_test_dir($test_case);
  return $suite if $suite;
  die "Suite class " . $test_case . " not found: $@";
 
}

sub try_test_case {
  my $test_case=shift;
  no strict 'refs';
  if ($test_case->isa("Test::Unit::TestCase")) {
	return Test::Unit::TestSuite->new($test_case);
  } 
}
sub try_test_suite {
  my $test_case=shift;
  no strict 'refs';
  if ($test_case->can("suite")) {
	return $test_case->suite();
  } 
}
sub try_test_harness {
  my $test_case=shift;
  if (-r $test_case) {
	my $fh = new FileHandle;
	$fh->open($test_case) or return;
	my $first = <$fh>;
	$fh->close or return;
	return Test::Unit::UnitHarness->new($test_case);
  }
}
sub try_test_dir {
  my $test_case=shift;
  if (-d $test_case) {
	die "This is a test directory. I havent implemented that.\n";
	return Test::Unit::UnitHarness::new_dir($test_case);
  }
}


1;
