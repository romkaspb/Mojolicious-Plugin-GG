package Mojolicious::Plugin::Admin::Panel::Controller;
use Mojo::Base 'Mojolicious::Plugin::Admin::Panel';

# has keys => { [] };
# has nested_controllers => { [] };
has name => 'default';

sub new {
  my($class, $name, $config) = @_;

  my $self = {
    name    => $name,
  };

  bless $self, $class;
}


1;
