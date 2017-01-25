package Mojolicious::Plugin::Admin;
use Mojo::Base 'Mojolicious::Plugin';

use Mojo::File 'path';

our $VERSION = '0.01';

has panel => sub { Mojolicious::Plugin::Admin::Panel->new(shift) };

sub register {
  my ($self, $app, $config) = @_;
  # INIT

  # Append "templates" and "public" directories
  my $base = path(__FILE__)->dirname->child('Admin');
  push @{$app->renderer->paths}, $base->child('templates')->to_string;
  push @{$app->static->paths},   $base->child('public')->to_string;
  $app->defaults(layout => 'admin');

  $config = undef unless keys %$config;
  die $config;
  $config ||= $app->plugin('Config', { file => 'admin.conf' }) || die __PACKAGE__." no config defined";

  $app->config->{admin} = $config;

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
    my $self = shift;

    # check auth
    return 1;
  });
  $admin->get('/')->to(cb => sub {
    shift->render('index');
    });

  $admin->get('/dashboard')->to(cb => sub {

  });

  $self->panel( $config );


  $app->helper( 'admin.generate_routes' => sub {
    my $self = shift;
    my $config = shift;

    my $routes_names_array = _build_routes_array( $config->{controllers}, undef );
    die $self->dumper( $config );
    die $self->dumper( $routes_names_array );
  });


  $app->hook( before_dispatch => sub { my $c = shift; $c->admin->generate_routes; } );
}

sub _build_routes_array{
  my ( $self, $controllers, $routes, $current ) = @_;
  $routes   ||= [];
  $current  ||= [];

  if ( scalar @$current ){
    my $ckey = $current->[ scalar @$current ];

    push @$current, $ckey;

    if( $controllers->{ $ckey }->{nested} ){
      _build_routes_array( $controllers->{ $ckey }, $routes, $current );
    }else{
      push @$routes, $current;
    }
  }

  foreach my $ckey ( keys %$controllers ){
    push @$current, $ckey;
    if( $controllers->{ $ckey }->{nested} ){
      _build_routes_array( $controllers->{ $ckey }, $routes, $current );
    }else{
      push @$routes, $current;
    }
  }

  return $routes;
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
