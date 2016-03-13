This is incomplete try to system_verilog/uvm completion engine.  

This is written in perl.
The perl module system_verilog::parse is the module that parses a system_verilog project, and creates a sqlite database with packages, classes, variables, and functions.

If you are using this as a starting point take a look into the lib/system_verilog/parse.pm file for examples on how to parse system verilog


To parse. my $parser= system_verilog::parse->new(db_file=><location of database>,follow_inc =>1,inc_dirs=>['include 1', 'include 2']);
$parser->parse_file('files');

At this point of time there is no script that will pull the information from the database. So you will need to pull that data out.

Look in t/t0.t for examples.

Unfortunatively I haven't touched this code in many years, and no longer work with system_verilog so I will not be able to help out to much

To install use perl's cpanm installer.

Unzip the tar.gz and run cpanm . from there.  


