use strict;
use warnings;
use Test::More;
use Test::LeakTrace;

use Callback;

my $return = do_callback(sub { uc shift }, "foo");

is $return, "FOO";

no_leaks_ok {
    my $r = do_callback(sub { uc shift }, "foo");
};

my $foo = "foo";
do_callback(sub { $_[0] =~ s/o/O/g }, $foo);
is $foo, "fOO";

done_testing;

