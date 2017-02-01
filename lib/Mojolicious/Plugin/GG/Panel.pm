package Mojolicious::Plugin::GG::Panel;
use Mojo::Base 'Mojolicious::Plugin::GG';

use Mojolicious::Plugin::GG::Panel::Controller;
use Mojolicious::Plugin::GG::Panel::Key;

# has version     => $Mojolicious::Plugin::GG::VERSION;
has current_controller => undef;
# has settings    => {};
# has keys        => [];
# has controllers => [];

sub new{
  my($class, $config) = @_;


  # parse controllers
  my $controllers = [];
  foreach ( keys %{ $config->{ controllers } } ){
    push @$controllers, Mojolicious::Plugin::GG::Panel::Controller->new( $_, $config->{controllers}->{ $_ } );
  }

  # parse keys
  my $keys = [];
  foreach ( keys %{ $config->{ keys } } ){
    push @$keys, Mojolicious::Plugin::GG::Panel::Key->new( $_, $config->{keys}->{ $_ } );
  }

  my $self = {
    controllers => $controllers,
    keys        => $keys,
  };

  bless $self, $class;
}

1;
