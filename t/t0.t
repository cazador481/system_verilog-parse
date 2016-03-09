#!/usr/perl -t
use Test::More;   # see done_testing()
BEGIN {
    use_ok( 'system_verilog::parse' ); 
};
BEGIN{
    use_ok( 'system_verilog::completion');
};
use Test::DBIx::Class
{
    schema_class =>'system_verilog::parse::Schema',

    connect_info=>['dbi:SQLite:dbname=:memory:','',''],
#connection_opts=>{name_sep =>'.',quote_char =>'`'},
},'Class','Variable','Function','Package';

my $schema=Schema();
my $test=system_verilog::parse->new(schema=>$schema,db_file=>"$ENV{HOME}/Dropbox/system_verilog-parse/verilog.db3",follow_inc=>1,inc_dirs=> ["$ENV{HOME}/Dropbox/system_verilog-parse/t/ovm-2.1.2/src"]);
$test->schema->txn_begin();
$test->parse_file("$ENV{HOME}/Dropbox/system_verilog-parse/t/ovm-2.1.2/src/ovm_pkg.sv");
my $rs=$test->schema->resultset('Class')->find({name=>'tlm_fifo'});
is_fields ['name','extends_name'], $rs,['tlm_fifo','tlm_fifo_base'];
my $fifo_rs= $test->schema->resultset('Class')->find({name=>'tlm_fifo'});
my @array=qw(new get_type_name size used is_empty is_full put get peek try_get try_peek try_put can_put can_get can_peek flush);
my @funcs=$fifo_rs->function_names();
is_deeply(\@funcs,\@array,'check functions');

# say join(' ', uniq $test->schema->resultset('Class')->single({name=>$fifo_rs->extends_name})->function_names());
# #list functions in itself, and what it extends
# say join(' ', uniq $test->schema->resultset('Class')->single({name=>$fifo_rs->extends_name})->function_names(),$fifo_rs->function_names);
my $comp=system_verilog::completion->new(_schema=>$schema,db_file=>'');
@funcs=$comp->_all_func({name=>'tlm_fifo'});
is_deeply(\@funcs,\@array,'check functions inheritance completion');


$test->schema->txn_rollback();
&done_testing();
