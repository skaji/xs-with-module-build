use strict;
use Test::More;

use External::Lib::Remote;

is(External::Lib::Remote::xs_add(1, 2), 3);

done_testing;

