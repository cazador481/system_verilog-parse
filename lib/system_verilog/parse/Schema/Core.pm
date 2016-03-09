# my own versino of DBIx::Class::Core
#
use strict;
use warnings;
package system_verilog::parse::Schema::Core;
use base 'DBIx::Class::Core';
# set 
#local $Data::Dumper::Freezer='_dumper_hook';
sub _dumper_hook {
    $_[0] = bless {
        %{ $_[0] },
        _result_source => undef,
    }, ref($_[0]);
}

1;
