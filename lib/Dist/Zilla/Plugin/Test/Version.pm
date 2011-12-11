package Dist::Zilla::Plugin::Test::Version;
use 5.006;
use strict;
use warnings;
BEGIN {
	our $VERSION = '0.001004'; # VERSION
}
use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';

__PACKAGE__->meta->make_immutable;
1;

# ABSTRACT: release Test::Version tests




=pod

=head1 NAME

Dist::Zilla::Plugin::Test::Version - release Test::Version tests

=head1 VERSION

version 0.001004

=head2 SYNOPSIS

in C<dist.ini>

	[Test::Version]

=head2 DESCRIPTION

This module will add a L<Test::Version> test as a release test to your module.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/xenoterracide/Dist-Zilla-Plugin-Test-Version/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut


__DATA__
__[ xt/release/test-version.t ]__
#!/usr/bin/perl
use 5.006;
use strict;
use warnings;
use Test::More;

use Test::Requires {
    'Test::Version' => 0.04,
};

version_all_ok;
done_testing;
