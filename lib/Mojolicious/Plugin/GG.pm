package Mojolicious::Plugin::GG;
use Mojo::Base 'Mojolicious::Plugin';

use Mojo::File 'path';

use Mojolicious::Plugin::GG::Panel;

has version => '0.01';


sub register {
  my ($self, $app, $config) = @_;
  # INIT

  # Append "templates" and "public" directories
  my $base = path(__FILE__)->dirname->child('GG');
  push @{$app->renderer->paths}, $base->child('templates')->to_string;
  push @{$app->static->paths},   $base->child('public')->to_string;
  $app->defaults(layout => 'admin');

  $config = undef unless keys %$config;

  $config = $app->plugin('Config', { file => 'admin.conf' }) || die __PACKAGE__." no config defined";
  $config = $config->{admin};

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

 # my $routes_names_array = _build_routes_array( $config->{controllers}, undef );

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

  $admin->resource('texts');

  # $app->attr(panel => Mojolicious::Plugin::GG::Panel->new( $config ));
  #unless (ref($app)->can('panel')) {
    ref($app)->attr('gg');
    $app->gg(Mojolicious::Plugin::GG::Panel->new( $config ));
  # #}

# $app->hook( before_dispatch => sub { my $c = shift; $c->admin->generate_routes; } );
}

# sub _build_routes_array{
#   my ( $controllers, $routes, $current ) = @_;
#   $routes   ||= [];
#   $current  ||= [];
#   use Data::Dumper;
#   warn Dumper $current;
#   if ( scalar @$current ){

#     my $ckey = $current->[ scalar @$current ];
#   # warn $ckey;
#     push @$current, $ckey;

#     if( $controllers->{ $ckey }->{nested} ){
#       _build_routes_array( $controllers->{ $ckey }, $routes, $current );
#     }else{
#       push @$routes, $current;
#     }
#   }

#   foreach my $ckey ( keys %$controllers ){
#     push @$current, $ckey if $ckey ne 'nested';
#     #warn $ckey;
#     if( $controllers->{ $ckey }->{nested} ){
#       _build_routes_array( $controllers->{ $ckey }, $routes, $current );
#     }else{
#       push @$routes, $current;
#     }
#   }

#   return $routes;
# }

1;

__END__

=encoding utf8

=head1 NAME

Mojolicious::Plugin::GG - plugin with adminpanel, new generation :)

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('GG');

  # Mojolicious::Lite
  plugin 'admin';

=head1 DESCRIPTION

L<Mojolicious::Plugin::GG> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::GG> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicious.org>.

=cut
