use 5.006;
use strict;
use warnings;
use Test::More;

use Capture::Tiny qw(capture);
use Path::Class;

# Make sure that when we run bin/test it is the one we think it is.
my $script = file(qw[bin test])->absolute;
my @perl = ($^X);
my @perl_args = (map { "-I$_" } @INC);
            # map: brute-force our @INC down to the other perl invocation
            # so that we can run tests with -Ilib.

my ($stdout, $stderr, $exit);

($stdout, $stderr, $exit) = capture {
    return system(@perl, @perl_args, $script);
};
cmp_ok $exit>>8, '==', 0, 'no-arg exit code';

($stdout, $stderr, $exit) = capture {
    return system(@perl, @perl_args, $script, '-h');
};
cmp_ok $exit>>8, '==', 0, '-h exit code';
like $stdout, qr/^Usage:/m, '-h text';

($stdout, $stderr, $exit) = capture {
    return system(@perl, @perl_args, $script, '--man');
};
cmp_ok $exit>>8, '==', 0, '--man exit code';
like $stdout, qr/ARGUMENTS/, '--man text';

($stdout, $stderr, $exit) = capture {
    return system(@perl, @perl_args, $script, '-~');
};
cmp_ok $exit>>8, '>', 0, 'unknown option exit code';
like $stderr, qr/^Unknown.+~/m, 'unknown option text';

($stdout, $stderr, $exit) = capture {
    return system(@perl, @perl_args, $script, '--other');
};
cmp_ok $exit>>8, '==', 0, '--other exit code';
like $stdout, qr/^--other given$/m, '--other text';

done_testing;
