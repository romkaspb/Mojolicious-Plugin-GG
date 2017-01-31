package Mojolicious::Plugin::Admin::Panel::Setting;
use Mojo::Base 'Mojolicious::Plugin::Admin::Panel';

has name    => '';
has value   => '';

sub new {
  my($class, $name, $value) = @_;

  my $self = {
    name    => $name,
    value   => $value,
  };

  bless $self, $class;
}

1;
