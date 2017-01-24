package Mojolicious::Plugin::Admin;
use Mojo::Base 'Mojolicious::Plugin';

use Mojo::File 'path';

our $VERSION = '0.01';

sub register {
  my ($self, $app) = @_;
  # INIT
  $app->title('GGSB Admin Panel ('. $app->mode .')');
  # Append "templates" and "public" directories
  my $base = path(__FILE__)->dirname->child('Admin');
  push @{$app->renderer->paths}, $base->child('templates')->to_string;
  push @{$app->static->paths},   $base->child('public')->to_string;

  my $r = $app->routes;
  # generate routes first
  $r->add_shortcut(resource => sub {
    my ($r, $name) = @_;

    my $resource = $r->any("/$name")->to("$name#");
    $resource->get->to('#index')->name($name);
    $resource->get('/create')->to('#create')->name("create_$name");
    $resource->post->to('#store')->name("store_$name");
    $resource->get('/:id')->to('#show')->name("show_$name");
    $resource->get('/:id/edit')->to('#edit')->name("edit_$name");
    $resource->put('/:id')->to('#update')->name("update_$name");
    $resource->delete('/:id')->to('#remove')->name("remove_$name");

    return $resource;
  });

  my $admin = $r->under('/admin')->to(cb => sub {
    # check auth
    return 1;
  });
  $admin->get('/')->to(cb => sub {
    shift->render('index');
    });
  # $admin->get('/dashboard')->to

}

1;

__END__

=encoding utf8

=head1 NAME

Mojolicious::Plugin::Admin - plugin with adminpanel, new generation :)

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('admin');

  # Mojolicious::Lite
  plugin 'admin';

=head1 DESCRIPTION

L<Mojolicious::Plugin::Admin> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::Admin> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicious.org>.

=cut
