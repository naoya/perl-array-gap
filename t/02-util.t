use strict;
use warnings;
use Test::More qw/no_plan/;

use Array::Gap::Util;

is encode_vb(1231), pack('w', 1231);
is decode_vb( encode_vb(1231) ), 1231;


