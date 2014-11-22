package builder::MyBuilder;
use strict;
use warnings;

use parent 'Module::Build';

sub new {
    my ($class, %arg) = @_;
    $class->SUPER::new(
        %arg,
        include_dirs => ["external"],
        extra_linker_flags => ["-Lexternal", "-ladd"],
    );
}

use Config;
my $make = $Config{make};
sub run { !system @_ or die "Failed @_\n" }

sub ACTION_code {
    my $self = shift;
    run $make, qw(-C external libadd.a);
    $self->SUPER::ACTION_code(@_);
}

sub ACTION_clean {
    my $self = shift;
    run $make, qw(-C external clean);
    $self->SUPER::ACTION_clean(@_);
}

1;
