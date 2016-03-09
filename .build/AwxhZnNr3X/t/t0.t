use Test::More;   # see done_testing()
BEGIN { use_ok( 'Some::Module' ); }
require_ok( 'Some::Module' );
done_testing();
use system_verilog::parse;
my $test=system_verilog::parse->(file=>"$ENV{HOME}/system_verilog-parse/verilog.db3");

$test->parse_file;

