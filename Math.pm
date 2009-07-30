package Math;

use 5.010;

use strict;
use warnings;
no  warnings 'syntax';

use List::Util 'sum';

use Exporter ();
our @EXPORT = qw [primes divisors not_perfect is_prime];
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

#
# Return whether a number is prime
#
sub is_prime {
    my $n = shift;
    my @p = primes int sqrt $n;
    foreach my $p (@p) {
        return 0 if $n % $p == 0;
    }
    return 1;
}


#
# Return all the divisors of a number
#
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


#
# Return -1 if the given number is deficient, 0 if the number is perfect,
# and 1 if the number is abundant.
#
sub not_perfect ($) {
    my  $n = shift;
    my  @d = divisors $n;
    pop @d;
    my  $s = sum @d;

    $s <=> $n;
}


1;

__END__
