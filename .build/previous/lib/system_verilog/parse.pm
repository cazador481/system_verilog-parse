# ABSTRACT: Dummy
use strict;
use warnings;
package system_verilog::parse;
{
  $system_verilog::parse::VERSION = '0.001';
}
use Moo;
use system_verilog::parse::Schema;
has db_file=>(is=>'ro',required=>1);
has schema=>(is=>'ro', lazy=>1,
    default=>sub {
        my $self=shift;
        system_verilog::schema::parse->connect($self->db_file);
    },
);
sub parse_file
{
    my $self=shift;
    my $file=shift;
    my @lines=read_file($file);
    my $class;
    my $in_func=0;
    my $in_class=0;
    my $in_task=1;
    my $func_type;
    my $func;
    my $line_num=0;
    my $in_class=0;
    foreach my $line (@lines)
    {
        $line_num++;
        chomp $line;
        next if ($line=~m!^//!);  #skip comment
        next if ($line=~/^\s*$/); # skip blank line
        if ($line=~/^\s*class\s*(\w+)/)
        {
            $in_class=1;
            $class=$self->schema->resultset('Class')->Create(
                {
                    name=>$1;
                    file=>$file;

                }
            );
            #say "found class:",$class->name;
            next;
        }
        elsif($line=~/^\s*endclass/)
        {
            $in_class=0;
        }
        elsif ($in_class && $line=~/^\s*(?:virtual\s)?(task|function)\s/)
        {
            $in_func=1;
            $func_type=$1;
            $func_name=$self->get_func_name($line);
            $func=$class->create_related('function',{name=>$func_name,line_num=>$line_num,type=>$func_type},);
            #my $obj={name=>$func,line_num=>$line_num};
            #$class->{$func_type}->{$func}=$obj;
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
                $var=$func->create_related('variables',{name=>$2,class_name=>$1});

                #$class->{$func_type}->{$func}->{var}->{$2}=$1;
            }
            $var=$class->create_related('variables',{name=>$2,class_name=>$1});
            #$class->{var}->{$2}=$1
        }
    }
}

sub get_func_name
{
    my $self=shift;
    my $line=shift;
    $line=~s/\(.*//; # remove paren
    $line=~/(\w+)\s*$/;
    return $1;

}

sub do_final_matching
{
    my $self=shift;
}

1;
