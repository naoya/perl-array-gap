use strict;
use warnings;
use Test::More qw/no_plan/;

use Array::Gap;

my $array = Array::Gap->new;
ok defined $array;

my @values = (824, 829, 830, 1024, 215406);

$array->push($_) for @values;

is '100001100011100000000101000000011000000101000010100011011000101001101110', $array->as_string;
is_deeply \@values, $array->as_array;

my @values_from_iter;
my $it = $array->iterator;
while ($it->has_next) {
    push @values_from_iter, $it->next;
}

is_deeply \@values, \@values_from_iter;

my $bin = $array->bin;
my $loaded = Array::Gap->new( $bin );

is_deeply \@values, $loaded->as_array;

$loaded->push(215407);

is_deeply [ @values, 215407 ], $loaded->as_array;
