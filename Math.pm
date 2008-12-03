package Math;

use 5.010;

use strict;
use warnings;
no warnings 'syntax';

use Exporter ();
our @EXPORT = qw [primes divisors];
our @ISA    = qw [Exporter];

#
# Returns a list of primes less or equal to the given number.
#
sub primes {
    my $n  = shift;
    my @p  = (1) x ($n + 1);
    $p [0] = 0;
    $p [1] = 0;
    for (my $i = 4; $i < @p; $i += 2) {$p [$i] = 0}
    for (my $i = 3; $i <= sqrt (@p); $i += 2) {
        next unless $p [$i];
        for (my $j = $i * $i; $j < @p; $j += 2 * $i) {$p [$j] = 0}
    }
    grep {$p [$_]} 2 .. $n;
}


sub divisors {
    my $n = shift;
    my @divs;
    for (my $k = 1; $k < sqrt ($n); $k ++) {
        next if $n % $k;
        push @divs => $k, $n / $k;
    }
    push @divs => sqrt ($n) if sqrt ($n) == int sqrt ($n);
    @divs = sort {$a <=> $b} @divs;
    @divs;
}

1;

__END__
