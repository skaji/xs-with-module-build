package Callback;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";
use Exporter 'import';
our @EXPORT = qw(do_callback);

use XSLoader;
XSLoader::load(__PACKAGE__, $VERSION);

1;
__END__

=encoding utf-8

=head1 NAME

Callback - It's new $module

=head1 SYNOPSIS

    use Callback;

=head1 DESCRIPTION

Callback is ...

=head1 LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Shoichi Kaji E<lt>skaji@cpan.orgE<gt>

=cut

