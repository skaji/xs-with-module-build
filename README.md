This repo shows how to develop xs module with Module::Build / Minilla.

See also https://metacpan.org/pod/Module::Build::XSUtil

### Case1. Basic

This is very basic, one `.xs` file. Just type:

    > minil new -p XS Basic

Then you'll get `lib/Basic.xs` file.

### Case2. Separated source files

Let's say you have `.c` and `.h` files in `src/` directory:

    > minil new -p XS Separated::Src
    > cd Separated-Src
    > vim src/add.h src/add.c
    ...

To build files in `src/` files, we have to modify `minil.toml`:
```
name = "Separated-Src"
c_source = ["src"]
```

### Case3. External libraries

Let's say you want to link an external library with your xs module.

    > minil new -p XS External::Lib
    > cd External-Lib
    > cp -r /path/to/external ./external
    > ls external
    Makefile  add.c  add.h

Note that the external library has own `Makefile`.
To build external library with its own `Makefile` and link it,
we modify `minil.toml` and create `builder/MyBuidler.pm`:

```
name = "External-Lib"
[build]
build_class = "builder::MyBuilder"
```
```perl
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
```

### Case4. External libraries in remote

If your external libraries in remote uri
(which can be fetched by git or svn or http get),
then modify `ACTION_code` by:

```perl
sub ACTION_code {
    my $self = shift;
    if (!-e "c-test/.git") {
        run "git", "clone", "git://github.com/shoichikaji/c-test.git";
    }
    run $make, qw(-C c-test libadd.a);
    $self->SUPER::ACTION_code(@_);
}
```

### Case5. C++

If you write c++ code, then `builder/MyBuilder.pm` looks like:

```perl
sub new {
    my $class = shift;
    $class->SUPER::new(
        extra_compiler_flags => ["-xc++"],
        extra_linker_flags => ["-lstdc++"],
        @_,
    );
}
```
