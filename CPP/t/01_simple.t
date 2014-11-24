use strict;
use Test::More;

use CPP;

is(CPP::hello("John"), 'Hello John!');

done_testing;

