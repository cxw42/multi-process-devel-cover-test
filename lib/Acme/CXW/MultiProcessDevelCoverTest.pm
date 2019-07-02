package Acme::CXW::MultiProcessDevelCoverTest;

use 5.006;
use strict;
use warnings;
use Class::Tiny;
use Getopt::Long 2.34 qw(GetOptionsFromArray :config auto_help auto_version);
use Pod::Usage;

our $VERSION = '0.01';

sub run {
    my ($self, $lrArgv) = @_;
    my %opts;
    GetOptionsFromArray($lrArgv,\%opts, qw(man other)) or die "Bad option";
    pod2usage(-exitval => 0, -verbose => 2) if $opts{man};

    print "--other given\n" if $opts{other};

    return 0;
}

1; # End of Acme::CXW::MultiProcessDevelCoverTest
