package Mojolicious::Plugin::Admin::Panel::Controller;
use Mojo::Base 'Mojolicious::Plugin::Admin::Panel';

has keys => { [] };
has name => 'default';

sub new {
  my($class, $name, $config) = @_;

  my $self = {
    name    => $name,
    keys    => parse_keys( $config ),
  };

  bless $self, $class;
}

sub parse_keys {
  my ( $self, $config ) = @_;

}

1;
