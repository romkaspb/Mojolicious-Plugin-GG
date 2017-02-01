package Mojolicious::Plugin::GG::Panel::Controller;
use Mojo::Base 'Mojolicious::Plugin::GG::Panel';

sub new {
  my($class, $name, $config) = @_;

  my %keys = ();

  foreach my $key( keys %{ $config->{keys} } ){
  	my $key_conf = $config->{keys}->{ $key };
  	my $class_name = ucfirst( $key_conf->{ type } );
  	$keys{ $key } = eval("Mojolicious::Plugin::GG::Panel::Key::$class_name->new($key_conf)")#;or die __PACKAGE__.' - '.$@;
  }

  my $self = {
  	settings 	=> $config->{settings},
    name    	=> $name,
    keys 		=> \%keys,
  };

  bless $self, $class;
}

sub setting{
	return shift->settings->{ shift };
}


1;
