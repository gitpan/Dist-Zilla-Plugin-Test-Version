package Dist::Zilla::Plugin::Test::Version;
use 5.006;
use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '0.002000'; # VERSION

use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';
with 'Dist::Zilla::Role::TextTemplate';

around add_file => sub {
	my ( $orig, $self, $file ) = @_;

	$self->$orig(
		Dist::Zilla::File::InMemory->new({
			name    => $file->name,
			content => $self->fill_in_string(
				$file->content,
				{
					is_strict   => \$self->is_strict,
					has_version => \$self->has_version,
				},
			),
		})
	);
};

has is_strict => (
	is => 'ro',
	isa => 'Bool',
	lazy => 1,
	default => sub { 0 },
);

has has_version => (
	is => 'ro',
	isa => 'Bool',
	lazy => 1,
	default => sub { 1 },
);

__PACKAGE__->meta->make_immutable;
1;

# ABSTRACT: release Test::Version tests




=pod

=head1 NAME

Dist::Zilla::Plugin::Test::Version - release Test::Version tests

=head1 VERSION

version 0.002000

=head1 SYNOPSIS

in C<dist.ini>

	[Test::Version]
	is_strict   = 0
	has_version = 1

=head1 DESCRIPTION

This module will add a L<Test::Version> test as a release test to your module.

=head1 ATTRIBUTES

=head2 is_strict

set L<Test::Version is_strict|Test::Version/is_strict>

=head2 has_version

set L<Test::Version has_version|Test::Version/has_version>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/xenoterracide/Dist-Zilla-Plugin-Test-Version/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2012 by Caleb Cushing.

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
    'Test::Version' => 1,
    'version'       => 0.86,
};

my @imports = ( 'version_all_ok' );

my $params = {
    is_strict   => {{ $is_strict }},
    has_version => {{ $has_version }},
};

push @imports, $params
    if version->parse( $Test::Version::VERSION ) >= version->parse('1.002');


Test::Version->import(@imports);

version_all_ok;
done_testing;
