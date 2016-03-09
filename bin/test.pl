#!/usr/bin/perl
#use Test::More;   # see done_testing()
#BEGIN { use_ok( 'system_verilog::parse' ); }
use lib "$ENV{HOME}/Dropbox/system_verilog-parse/lib/";
use List::MoreUtils qw(uniq);
use system_verilog::parse;
use Data::Dumper;
use feature qw(say);
use system_verilog::completion;
local $Data::Dumper::Freezer='_dumper_hook';

my $test=system_verilog::parse->new(db_file=>"$ENV{HOME}/Dropbox/system_verilog-parse/verilog.db3",follow_inc=>1,inc_dirs=> ["$ENV{HOME}/Dropbox/system_verilog-parse/t/ovm-2.1.2/src"]);
$test->schema->txn_begin();
$test->parse_file("$ENV{HOME}/Dropbox/system_verilog-parse/t/ovm-2.1.2/src/ovm_pkg.sv");
# say Dumper($test->schema->resultset('Function')->search({'class.name'=>'tlm_fifo'},{ join =>['class']}));
 say Dumper($test->schema->resultset('Class')->find({name=>'tlm_fifo'}));
my $fifo_rs= $test->schema->resultset('Class')->find({name=>'tlm_fifo'});
foreach my $res ( $fifo_rs->functions)
{
    say $res->name();
}

say  join(' ',$fifo_rs->function_names());

say join(' ', uniq $test->schema->resultset('Class')->single({name=>$fifo_rs->extends_name})->function_names());
#list functions in itself, and what it extends
say join(' ', uniq $test->schema->resultset('Class')->single({name=>$fifo_rs->extends_name})->function_names(),$fifo_rs->function_names);

# my $comp=system_verilog::completion->new();
# say $comp->_all_func({name=>'tlm_fifo'});

# say  join(' ',$fifo_rs->extend_func_names());


$test->schema->txn_rollback();
