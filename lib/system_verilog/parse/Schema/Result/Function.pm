use utf8;
package system_verilog::parse::Schema::Result::Function;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

system_verilog::parse::Schema::Result::Function

=cut

use strict;
use warnings;

use base 'system_verilog::parse::Schema::Core';

=head1 TABLE: C<Function>

=cut

__PACKAGE__->table("Function");

=head1 ACCESSORS

=head2 function_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0
=head2 file

  data_type: 'text'
  is_nullable: 0


=head2 type

  data_type: 'text'
  is_nullable: 0

=head2 line_num

  data_type: 'integer'
  is_nullable: 0

=head2 class_id

  data_type: (empty string)
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "function_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "file",
  { data_type => "text", is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "type",
  { data_type => "text", is_nullable => 0 },
  "line_num",
  { data_type => "integer", is_nullable => 0 },
  "class_id",
  { data_type => "", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</function_id>

=back

=cut

__PACKAGE__->set_primary_key("function_id");

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
    on_update     => "NO ACTION",
  },
);

=head2 variables

Type: has_many

Related object: L<system_verilog::parse::Schema::Result::Variable>

=cut

__PACKAGE__->has_many(
  "variables",
  "system_verilog::parse::Schema::Result::Variable",
  { "foreign.function_id" => "self.function_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-29 20:59:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4fpYN7wV1Bh4wxcv8Tk3cQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

