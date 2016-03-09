use utf8;
package MyApp::Schema::Result::Class;
{
  $MyApp::Schema::Result::Class::VERSION = '0.001';
}

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Class

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<Class>

=cut

__PACKAGE__->table("Class");

=head1 ACCESSORS

=head2 class_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 file

  data_type: 'text'
  is_nullable: 1

=head2 line_num

  data_type: 'integer'
  is_nullable: 1

=head2 extends

  data_type: 'integer'
  is_nullable: 1

=head2 package_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "class_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "file",
  { data_type => "text", is_nullable => 1 },
  "line_num",
  { data_type => "integer", is_nullable => 1 },
  "extends",
  { data_type => "integer", is_nullable => 1 },
  "package_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</class_id>

=back

=cut

__PACKAGE__->set_primary_key("class_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<file_unique>

=over 4

=item * L</file>

=back

=cut

__PACKAGE__->add_unique_constraint("file_unique", ["file"]);

=head1 RELATIONS

=head2 functions

Type: has_many

Related object: L<MyApp::Schema::Result::Function>

=cut

__PACKAGE__->has_many(
  "functions",
  "MyApp::Schema::Result::Function",
  { "foreign.class_id" => "self.class_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 imports

Type: has_many

Related object: L<MyApp::Schema::Result::Import>

=cut

__PACKAGE__->has_many(
  "imports",
  "MyApp::Schema::Result::Import",
  { "foreign.class_id" => "self.class_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 package

Type: belongs_to

Related object: L<MyApp::Schema::Result::Package>

=cut

__PACKAGE__->belongs_to(
  "package",
  "MyApp::Schema::Result::Package",
  { package_id => "package_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 variables

Type: has_many

Related object: L<MyApp::Schema::Result::Variable>

=cut

__PACKAGE__->has_many(
  "variables",
  "MyApp::Schema::Result::Variable",
  { "foreign.class_id" => "self.class_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2013-12-29 20:59:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:PJy6dK8WSMDoTVEkdGfRAw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
