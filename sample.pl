#!/usr/bin/env/perl
use strict;
use warnings;

use FindBin::libs;
use Perl6::Say;
use Array::Gap;

my $array = Array::Gap->new;
$array->push(824);
$array->push(829);
$array->push(830);
$array->push(1024);
$array->push(215406);

my $it = $array->iterator;
while ($it->has_next) {
    say $it->next;
}


