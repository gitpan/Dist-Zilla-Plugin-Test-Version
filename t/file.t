use strict;
use warnings;
use Test::More;
use Test::DZil;
use Test::Script 1.05;

my $tzil
	= Builder->from_config(
		{
			dist_root    => 'corpus/a',
		},
		{
			add_files => {
				'source/dist.ini' => simple_ini(['Test::Version'])
			}
		},
	);

$tzil->build;

my $fn
	= $tzil
	->tempdir
	->subdir('build')
	->subdir('xt')
	->subdir('release')
	->file('test-version.t')
	;

ok ( -e $fn, 'test file exists');

script_compiles( '' .$fn->relative, 'check test compiles' );

done_testing;
