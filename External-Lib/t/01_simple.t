use strict;
use Test::More;

use External::Lib;

is(External::Lib::xs_add(1,2), 3);

done_testing;

