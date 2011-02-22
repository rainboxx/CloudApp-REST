use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'CloudApp::REST',
    license             => 'perl',
    dist_author         => q{Matthias Dietrich <perl@rainboxx.de>},
    dist_version_from   => 'lib/CloudApp/REST.pm',
    build_requires => {
        'Test::More' => 0,
        'MooseX::Types::URI' => 0,
        'MooseX::Types::DateTimeX' => 0,
        'Moose::Role' => 0,
        'Moose' => 0,
        'JSON::XS' => 0,
        'HTTP::Request' => 0,
        'Data::Dumper' => 0,
        'LWP::UserAgent' => 0,
        'Carp' => 0,
        'Readonly' => 0,,
        'Module::Load' => 0,
    },
    configure_requires => { 'Module::Build' => 0.36 },
    add_to_cleanup => [ 'CloudApp-REST-*' ],
    create_makefile_pl => 'traditional',
    meta_merge => {
        resources => {
            repository => 'git://github.com/rainboxx/CloudApp-REST.git',
            homepage   => 'http://github.com/rainboxx/CloudApp-REST/',
            bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=CloudApp-REST',
        }
    },
);

$builder->create_build_script();
