package Alien::Libarchive::MSWin32::ModuleBuild;

use strict;
use warnings;
use base qw( Alien::Base::ModuleBuild );
use Config;

my $cflags = '';
my $libs   = '';
  
sub alien_do_commands
{
  my($self, $phase) = @_;

  unless($cflags)
  {
    my $first = 1;
    foreach my $name (qw( Alien::bz2 ))
    {
      my $alien = eval qq{ require $name; $name->new };
      next if $@;
      print "\n\n" if $first; $first = 0;
      print "  trying to use $name\n";
      $cflags .= ' ' . $alien->cflags;
      $libs   .= ' ' . $alien->libs;
    }
    print "\n\n" unless $first;
  }

  local $ENV{CFLAGS} = $cflags;
  local $ENV{LIBS}   = $libs;
  
  if($Config{ld} =~ /link(\.exe)?$/i)
  {
    $self->config_data( msvs => 1 );
  }
  
  $self->SUPER::alien_do_commands($phase);
}

package
  main;

use Alien::CMake;
use File::Which qw( which );
use Config;

sub _system
{
  my @cmd = @_;
  print "> @cmd\n";
  system @cmd;
  die 'command failed' if $?;
}

sub _make ()
{
  if($Config{make} =~ /nmake(\.exe)?$/)
  {
    return $Config{make};
  }
  else
  {
    return which('mingw32-make') || which('gmake') || which('make');
  }
}

my $make;

sub alien_build ()
{
  my $dir = shift @ARGV;
  my $cmake  = Alien::CMake->config('prefix') . '/bin/cmake.exe';
  $make   ||= _make();
  my $system = $Config{make} =~ /nmake(\.exe)?$/ ? 'NMake Makefiles' : 'MinGW Makefiles';
  _system $cmake,
    -G => $system,
    "-DCMAKE_MAKE_PROGRAM:PATH=$make",
    "-DCMAKE_INSTALL_PREFIX:PATH=$dir",
    "-DENABLE_TEST=OFF",
    "-DENABLE_TAR=OFF",
    "-DENABLE_CPIO=OFF",
    '.';
  _system $make, 'all';
}

sub alien_install ()
{
  $make   ||= _make();
  _system $make, 'install';
}

1;
