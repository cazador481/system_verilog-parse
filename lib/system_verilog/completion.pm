#
#===============================================================================
#
#         FILE: completion.pm
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 01/13/14 21:29:27
#     REVISION: ---
#===============================================================================


#NOTE:  This does not work at this point of time
use strict;
use warnings;
package system_verilog::completion;
use Moo;
use List::MoreUtils qw(uniq);
use Types::Path::Tiny qw(File);
has db_file=>(is=>'ro',isa=>File,required=>1,coerce=>1);
has _schema=>(is=>'ro', lazy=>1,
    builder=>'build_schema');
sub build_schema {
        my $self=shift;
        system_verilog::parse::Schema->connect('dbi:SQLite:'.$self->db_file);
}


sub _all_var
{
    my $self;
    my $opts=shift;
    #opts: class, package,filename
    my @names;
    if (! defined $self->_schema->extends_name)
    {
        #TODO: add package info based on imports to search
        @names=$self->_all_var({class=>$self->_schema->extends_name});
    }
    push (@names,  $self->_schema->resultset('Class')->single($opts)->variable_names());
    return uniq @names;
}

sub _all_func
{
    my $self=shift;
    my $opts=shift;
    #opts: class, package,filename
    my @names;
    if (! defined $self->_schema->extends_name)
    {
        #TODO: add package info based on imports to search
        @names=$self->_all_func({class=>$self->_schema->extends_name});
    }
    push (@names,  $self->_schema->resultset('Class')->single($opts)->function_names());
    return uniq @names;
}

sub complete_func 
{
    my $self=shift;
    my $opts=shift;
    #opts: line_num,class,package,buffer,filename
    
}

1;

