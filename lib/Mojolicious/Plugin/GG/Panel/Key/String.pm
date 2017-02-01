package Mojolicious::Plugin::GG::Panel::Key::String;
use Mojo::Base 'Mojolicious::Plugin::GG::Panel';

has name => 'default';

sub new {
  my($class, $name, $config) = @_;

  my $self = {
    name    => $name,
  };

  bless $self, $class;
}

1;
