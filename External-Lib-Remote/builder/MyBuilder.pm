package builder::MyBuilder;
use strict;
use warnings;

use parent 'Module::Build';

sub new {
    my ($class, %arg) = @_;
    $class->SUPER::new(
        %arg,
        include_dirs => ["c-test"],
        extra_linker_flags => ["-Lc-test", "-ladd"],
    );
}

use Config;
my $make = $Config{make};
sub run { !system @_ or die "Failed @_\n" }

sub ACTION_code {
    my $self = shift;
    if (!-e "c-test/.git") {
        run "git", "clone", "git://github.com/shoichikaji/c-test.git";
    }
    run $make, qw(-C c-test libadd.a);
    $self->SUPER::ACTION_code(@_);
}

sub ACTION_clean {
    my $self = shift;
    run $make, qw(-C c-test clean);
    $self->SUPER::ACTION_clean(@_);
}

use File::Path 'rmtree';
sub ACTION_realclean {
    my $self = shift;
    my $ret = $self->SUPER::ACTION_realclean(@_);
    rmtree "c-test" if -d "c-test";
    $ret;
}


1;
