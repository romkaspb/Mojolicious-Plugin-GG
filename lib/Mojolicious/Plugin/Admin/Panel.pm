package Mojolicious::Plugin::Admin::Panel;
use Mojo::Base 'Mojolicious::Plugin::Admin';

use Mojolicious::Plugin::Admin::Panel::Setting;
use Mojolicious::Plugin::Admin::Panel::Controller;
use Mojolicious::Plugin::Admin::Panel::Key;

has version     => 0.01;
has current_controller => undef;
# has settings    => {};
# has keys        => [];
# has controllers => [];

sub new{
  my($class, $config) = @_;

  # parse settings
  my $settings = [];
  foreach ( keys %{ $config->{settings} }){
    push $settings,     Mojolicious::Plugin::Admin::Panel::Setting->new( $_, $config->{settings}->{ $_ } );
  }

  # parse controllers
  my $controllers = [];
  foreach ( keys %{ $config->{ controllers } } ){
    push @$controllers, Mojolicious::Plugin::Admin::Panel::Controller->new( $_, $config->{controllers}->{ $_ } );
  }

  # parse keys
  my $keys = [];
  foreach ( keys %{ $config->{ keys } } ){
    push @$keys, Mojolicious::Plugin::Admin::Panel::Key->new( $_, $config->{keys}->{ $_ } );
  }

  my $self = {
    settings  => $settings,
    controllers => $controllers,
    keys        => $keys,
  };

  bless $self, $class;
}

1;
