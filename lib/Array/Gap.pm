package Array::Gap;
use strict;
use warnings;
# use base qw/Class::Accessor::Lvalue::Fast/;

use Array::Gap::Util;
use Array::Gap::Iterator;
# use Benchmark::Timer;

# __PACKAGE__->mk_accessors(qw/previous bin/);

use constant BIN      => 0;
use constant PREVIOUS => 1;

use overload
    '""'     => 'as_string',
    # '@{}'    => 'as_array',
    fallback => 1;

sub new {
    my ($class, $arg) = @_;

#     my $self = $class->SUPER::new;
#     $self->bin = '';
#     $self->previous = 0;
#     if (ref $arg eq 'ARRAY') {
#         for my $item (@$arg) {
#             $self->push($item);
#         }
#     } elsif ($arg) {
#         $self->bin      = $arg;
#         $self->previous = $self->as_array->[-1];  ## hmm..
#     }

    my $self = bless [], $class;

    $self->[BIN]      = '';
    $self->[PREVIOUS] = 0;

    if (ref $arg eq 'ARRAY') {
        for my $item (@$arg) {
            $self->push($item);
        }
    } elsif ($arg) {
        $self->[BIN]      = $arg;
        $self->[PREVIOUS] = $self->as_array->[-1];  ## hmm..
    }

    return $self;
}

sub bin {
    $_[0]->[BIN];
}

sub push {
    if ($_[1] == $_[0]->[PREVIOUS]) {
        return $_[1];
    }
    $_[0]->[BIN]      .= pack('w', $_[1] - $_[0]->[PREVIOUS]);
    $_[0]->[PREVIOUS]  = $_[1];

    return $_[1];
}

# sub insert {
#     my ($self, $n) = @_;
#     if ($self->previous < $n) {
#         $self->push($n);
#         return 1;
#     }

#     my $it = Array::Gap::Iterator->new({bin => $self->bin});
#     my $prefix = '';
#     my $m = 0;
#     my $prev = 0;
#     while ($m = $it->next) {
#         last if $n < $m;
#         $prefix = $it->read;
#         $prev = $m;
#     }
#     return 0 if $n == $prev;
#     $self->bin = $prefix . encode_vb($n - $prev) . encode_vb($m - $n);

#     $self->previous = $m;
#     $self->push($m) while ($m = $it->next);

#     return 1;
# }

## NOT USED
# sub delete {
#     my ($self, $n) = @_;
#     if ($self->previous < $n) {
#         return 0;
#     }

#     my $it = Array::Gap::Iterator->new({bin => $self->bin});
#     my $prefix = '';
#     my $m = 0;
#     my $prev = 0;
#     while ($m = $it->next) {
#         last if $n <= $m;
#         $prefix = $it->read;
#         $prev = $m;
#     }
#     return 0 if $n != $m;
#     $self->bin = $prefix;

#     $self->previous = $m;
#     $self->push($m) while ($m = $it->next);

#     return 1;
# }

sub iterator {
    return Array::Gap::Iterator->new($_[0]->[BIN]);
}

sub as_array {
    #my @values;
    # my $it = $_[0]->iterator;
    # while ($it->has_next) {
    #    CORE::push @values, $it->next;
    #}
    #return \@values;
    my $cur = 0;
    my @values = map { $cur += $_ } unpack('w*', $_[0]->[BIN]);
    return \@values;
}

sub as_string {
    return unpack('B*', $_[0]->[BIN]);
}

1;
