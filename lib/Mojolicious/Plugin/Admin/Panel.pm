package Mojolicious::Plugin::Admin::Panel;
use Mojo::Base 'Mojolicious::Plugin::Admin';

has version     => { 0.01 };
has settings    => { {} };
has keys        => { [] };
has controllers => { [] };


1;
