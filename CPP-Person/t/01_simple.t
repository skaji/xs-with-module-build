use strict;
use Test::More;

use CPP::Person;

my $person = CPP::Person->new("John", 22);

is $person->introduce, "My name is John, and I'm 22 year's old";
is $person->double_age, 44;

done_testing;

