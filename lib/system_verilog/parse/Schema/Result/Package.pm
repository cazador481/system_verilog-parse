use utf8;
package system_verilog::parse::Schema::Result::Package;

# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

system_verilog::parse::Schema::Result::Package

=cut

use strict;
use warnings;

use base 'system_verilog::parse::Schema::Core';

=head1 TABLE: C<Package>

=cut

__PACKAGE__->table("Package");

=head1 ACCESSORS

=head2 package_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 file

  data_type: 'text'
  is_nullable: 1

=head2 line_num

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "package_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "file",
  { data_type => "text", is_nullable => 1 },
  "line_num",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</package_id>

=back

=cut

__PACKAGE__->set_primary_key("package_id");

=head1 RELATIONS

=head2 classes

Type: has_many

Related object: L<system_verilog::parse::Schema::Result::Class>

=cut

__PACKAGE__->has_many(
  "classes",
  "system_verilog::parse::Schema::Result::Class",
  { "foreign.package_id" => "self.package_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 import_package_imports

Type: has_many

Related object: L<system_verilog::parse::Schema::Result::Import>

=cut

__PACKAGE__->has_many(
    
  "imported_packages",
  "system_verilog::parse::Schema::Result::Import",
  { "foreign.package_import" => "self.package_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 import_packages

Type: has_many

Related object: L<system_verilog::parse::Schema::Result::Import>

=cut

__PACKAGE__->has_many(
  "import_packages",
  "system_verilog::parse::Schema::Result::Import",
  { "foreign.package_id" => "self.package_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);



# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-29 20:59:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oTuVWwTT8aypKX2dhqOzNg


# You can replace this text with cABOVE! md5sum:oTuVWwTT8aypKX2dhqOzNg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->many_to_many(imports =>'import_packages','package_import');

__PACKAGE__->add_unique_constraint(['name']);
1;
