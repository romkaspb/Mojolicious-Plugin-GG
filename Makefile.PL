use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::GG',
  VERSION_FROM => 'lib/Mojolicious/Plugin/GG.pm',
  AUTHOR       => 'A Good Programmer <nospam@cpan.org>',
  PREREQ_PM    => {'Mojolicious' => '7.10'},
  test         => {TESTS => 't/*.t'}
);
