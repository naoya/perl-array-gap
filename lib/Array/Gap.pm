package Array::Gap;
use strict;
use warnings;
use base qw/Class::Accessor::Lvalue::Fast/;

use Array::Gap::Util;
use Array::Gap::Iterator;

__PACKAGE__->mk_accessors(qw/previous bin/);

use overload
    '""'     => 'as_string',
    '@{}'    => 'as_array',
    fallback => 1;

sub new {
    my ($class, $bin) = @_;
    my $self = bless $class->SUPER::new, $class;

    if ($bin) {
        $self->bin      = $bin;
        $self->previous = $self->as_array->[-1];  ## hmm..
    } else {
        $self->previous = 0;
    }

    return bless $self, $class;
}

sub push {
    my ($self, $n) = @_;

    $self->bin     .= encode_vb( $n - $self->previous );
    $self->previous = $n;

    return $n;
}

sub iterator {
    return Array::Gap::Iterator->new(shift->bin);
}

sub as_array {
    my @values;
    my $it = shift->iterator;
    while ($it->has_next) {
        CORE::push @values, $it->next;
    }
    return \@values;
}

sub as_string {
    return unpack('B*', shift->bin);
}

1;
