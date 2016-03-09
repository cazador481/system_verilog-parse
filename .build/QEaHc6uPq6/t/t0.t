use Test::More;   # see done_testing()
BEGIN { use_ok( 'system_verilog::parse' ); }

use system_verilog::parse;
my $test=system_verilog::parse->(file=>"$ENV{HOME}/system_verilog-parse/verilog.db3");

$test->parse_file;
&done_testing();

