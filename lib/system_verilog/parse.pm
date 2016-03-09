# ABSTRACT: Dummy
use strict;
use warnings;
use feature qw(say);
package system_verilog::parse;
use Moo;
use File::Slurp;
use system_verilog::parse::Schema;
=head 1 functions

=head 2 * new(db_file,follow_inc,inc_dirs, schema )

required parameters:
=item * db_file = path to th database file

optional parameters:

=item * follow_inc = follows includes when processing

=item * inc_dirs = directores to look for includes

=item * schema = path to the DBIX::Schema if already created

=cut

has db_file=>(is=>'ro',required=>1);
has follow_inc=>(is=>'ro',default=>0);
has inc_dirs=>(is=>'rw');
has schema=>(is=>'ro', lazy=>1,
    default=>sub {
        my $self=shift;
        system_verilog::parse::Schema->connect('dbi:SQLite:'.$self->db_file);
    },
);
has _package=>(is=>'rw',required=>0,predicate=>'has_package',clearer=>'clear_package');

#looks through the inc_dirs list and parses a file if it matches
sub follow_inc_file
{
    my $self=shift;
    my $file=shift;
    foreach my $inc_dir(@{$self->inc_dirs})
    {
        my $temp_file="$inc_dir/$file";
        if (-f "$temp_file")
        {
        $self->parse_file("$temp_file") 

        };
    }
}

=head 2 * $parse->parse_file('file_to_parse')

=cut

sub parse_file
{
    my $self=shift;
    my $file=shift;
    my @lines=read_file($file);
    my $class;
    my $in_func=0;
    my $in_class=0;
    my $in_task=1;
    my $func;
    my $line_num=0;
    foreach my $line (@lines)
    {
        $line_num++;
        chomp $line;
        next if ($line=~m!^//!);  #skip comment
        next if ($line=~/^\s*$/); # skip blank line
        #TODO: package parsing
        if ($line=~/^package (\w+)/)
        {
            use Data::Dumper;
            my $package_id=$self->schema->resultset('Package')->update_or_create({name=>$1,file=>$file,line_num=>$line_num},{key=>'Package_name'});
            $self->_package($package_id->package_id);
        }
        elsif($line=~/^endpackage\b/)
        {
            $self->clear_package();
        }
        elsif($line=~/^\s*import\s+(\w+)::\*/) #only import full package
        {
            my $package_id=$self->schema->resultset('Package')->update_or_create_related('imported_packages',{name=>$1,file=>$file,line_num=>$line_num},{key=>'name'});
        }
        elsif($self->follow_inc() && $line=~/^\s*`include\s+["'](.*)['"]/) # follows in the include tree
        {
            $self->follow_inc_file($1);
        }
        elsif ($line=~/^\s*(?:virtual )?class\s*(\w+)/)
        {
            $in_class=1;
            my $opts={ name=>$1,line_num=>$line_num,file=>$file };
            $class=$self->_process_class($line,$opts);
        }
        elsif($line=~/^\s*endclass/)
        {
            $in_class=0;
        }
        elsif ($in_class && $line=~/^\s*(?:virtual\s)?(task|function)\s/)
        {
            $in_func=1;
            my $func_type=$1;
            $func=$class->create_related('functions',{name=>$self->_get_func_name($line),line_num=>$line_num,type=>$func_type,file=>$file},);
            next;
        }
        elsif ($in_class && $line=~/^\s*end(task|function)\b/)
        {
            $in_func=0;
            next;
        }
        #look for variable
        elsif ($in_class && $line=~/^\s*(\w+)\s+(\w+);/)
        {
            my $var;
            if ($in_func)
            {
                $var=$func->create_related('variables',{name=>$2,class_name=>$1,file=>$file,line_num=>$line_num});
            }
            $var=$class->create_related('variables',{name=>$2,class_name=>$1,file=>$file,line_num=>$line_num});
        }
    }
}

sub _get_func_name
{
    my $self=shift;
    my $line=shift;
    $line=~s/\(.*//; # remove paren
    $line=~s/#.*//; # remove template
    $line=~/(\w+)\s*$/;
    die ("[$line]") if (! defined $1) ;
    return $1;

}

sub do_final_matching
{
    my $self=shift;
}

sub _process_class
{
    my $self=shift;
    my $line=shift;
    my $opts=shift;
    $opts->{extends_name}=$1 if ($line=~/extends (\w+)/);
    #todo create extends link

    if ($self->has_package)
    {
        $opts->{package_id}=$self->_package;
        #$class=$self->_package()->create_related('Classes',\%opts);#schema->resultset('Class')->create(\%opts
    }
    my $class=$self->schema->resultset('Class')->create($opts);
    return $class;
}

1;
