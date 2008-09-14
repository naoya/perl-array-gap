package Array::Gap::Iterator;
use strict;
use warnings;
use base qw/Class::Accessor::Lvalue::Fast/;
use Array::Gap::Util;

__PACKAGE__->mk_accessors(qw/bin current/);

sub new {
    my ($class, $bin) = @_;
    my $self = $class->SUPER::new({
        bin     => $bin,
        current => 0,
    });
    bless $self, $class;
}

sub has_next {
    shift->bin ? 1 : 0;
}

sub next {
    my $self = shift;

    if (my $n = decode_vb $self->bin) {
        $self->bin = substr($self->bin, length encode_vb $n);
        $self->current += $n;
        return $self->current;
    }

    return;
}

1;
