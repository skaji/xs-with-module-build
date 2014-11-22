package builder::MyBuilder;
use strict;
use warnings;
use parent 'Module::Build';

sub new {
    my ($class, %arg) = @_;
    $class->SUPER::new(
        %arg,
        c_source => ["src"],
    );
}

1;
