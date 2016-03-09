use utf8;
package system_verilog::parse::Schema::Result::Import;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

system_verilog::parse::Schema::Result::Import

=cut

use strict;
use warnings;

use base 'system_verilog::parse::Schema::Core';

=head1 TABLE: C<Import>

=cut

__PACKAGE__->table("Import");

=head1 ACCESSORS

=head2 import_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 package_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 class_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 package_import

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "import_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "package_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "class_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "package_import",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</import_id>

=back

=cut

__PACKAGE__->set_primary_key("import_id");

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

=head2 package

Type: belongs_to

Related object: L<system_verilog::parse::Schema::Result::Package>

=cut

__PACKAGE__->belongs_to(
  "package",
  "system_verilog::parse::Schema::Result::Package",
  { package_id => "package_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 package_import

Type: belongs_to

Related object: L<system_verilog::parse::Schema::Result::Package>

=cut

__PACKAGE__->belongs_to(
  "package_import",
  "system_verilog::parse::Schema::Result::Package",
  { package_id => "package_import" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-29 20:59:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uKXdSYZhIeJW2ItEeXz77g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

