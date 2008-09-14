package Array::Gap::Util;
use strict;
use warnings;
use Exporter::Lite;

our @EXPORT_OK = qw/encode_vb decode_vb/;
our @EXPORT = @EXPORT_OK;

sub encode_vb ($) {
    my $num = shift;
    pack('w', $num);
}

sub decode_vb ($) {
    my $num = shift;
    unpack('w', $num);
}

1;
