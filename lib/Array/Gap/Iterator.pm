package Array::Gap::Iterator;
use strict;
use warnings;
# use Array::Gap::Util;

use constant BIN     => 0;
use constant READ    => 1;
use constant CURRENT => 2;

sub new {
    my ($class, $bin) = @_;
    my $self = bless [], $class;
    $self->[BIN]     = $bin;
    $self->[READ]    = '';
    $self->[CURRENT] = 0;
    return $self;
}

sub has_next {
    $_[0]->[BIN] ? 1 : 0;
}

sub next {
    if (my $n = unpack('w', $_[0]->[BIN])) {
        my $vb =  pack('w', $n);
        $_[0]->[READ]    .= $vb;
        $_[0]->[BIN]     = substr($_[0]->[BIN], length $vb);
        $_[0]->[CURRENT] += $n;
        return $_[0]->[CURRENT];
    } else {
        warn "Can't decode bin: " . unpack('H*', $_[0]->[BIN] );
        $_[0]->[BIN] = '';
    }
    return;
}

1;
