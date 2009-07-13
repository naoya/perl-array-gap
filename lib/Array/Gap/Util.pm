package Array::Gap::Util;
use strict;
use warnings;
use Exporter::Lite;

our @EXPORT_OK = qw/encode_vb decode_vb/;
our @EXPORT = @EXPORT_OK;

sub encode_vb {
    pack('w', $_[0]);
}

sub decode_vb {
    unpack('w', $_[0]);
}

1;
