package builder::MyBuilder;
use strict;
use warnings;

use parent 'Module::Build';

# see https://metacpan.org/pod/Module::Build::XSUtil

sub new {
    my $class = shift;
    $class->SUPER::new(
        extra_compiler_flags => ["-xc++"],
        extra_linker_flags => ["-lstdc++"],
        @_,
    );
}

1;
