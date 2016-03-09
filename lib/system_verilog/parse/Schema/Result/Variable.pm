use utf8;
package system_verilog::parse::Schema::Result::Variable;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

system_verilog::parse::Schema::Result::Variable

=cut

use strict;
use warnings;

use base 'system_verilog::parse::Schema::Core';

=head1 TABLE: C<Variable>

=cut

__PACKAGE__->table("Variable");

=head1 ACCESSORS

=head2 variable_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 class_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 function_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 file

  data_type: 'text'
  is_nullable: 0

=head2 class_name

  data_type: 'text'
  is_nullable: 0

=head2 name


  data_type: 'text'
  is_nullable: 0

=head2 line_num

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "variable_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "class_name",
  { data_type => "text", is_nullable => 1 },
  "class_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "function_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "file",
  { data_type => "text", is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "line_num",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</variable_id>

=back

=cut

__PACKAGE__->set_primary_key("variable_id");

=head1 RELATIONS

=head2 class

Type: belongs_to

Related object: L<system_verilog::parse::Schema::Result::Class>

=cut

__PACKAGE__->belongs_to(
  "class",
  "system_verilog::parse::Schema::Result::Class",
  { class_id => "class_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 function

Type: belongs_to

Related object: L<system_verilog::parse::Schema::Result::Function>

=cut

__PACKAGE__->belongs_to(
  "function",
  "system_verilog::parse::Schema::Result::Function",
  { function_id => "function_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-29 20:59:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qEBZrn0wMCB+HOIAQHUqKw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

