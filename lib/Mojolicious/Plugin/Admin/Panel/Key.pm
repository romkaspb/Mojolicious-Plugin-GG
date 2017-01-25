package Mojolicious::Plugin::Admin::Panel::Key;
use Mojo::Base 'Mojolicious::Plugin::Admin::Panel';

has name => 'default';

sub new {
  my($class, $name, $config) = @_;

  my $self = {
    name    => $name,
  };

  bless $self, $class;
}

1;
