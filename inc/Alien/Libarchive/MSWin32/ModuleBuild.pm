package Alien::Libarchive::MSWin32::ModuleBuild;

use strict;
use warnings;
use base qw( Alien::Base::ModuleBuild );

package
  main;

use Alien::CMake;
use File::Which qw( which );

sub _system
{
  my @cmd = @_;
  print "> @cmd\n";
  system @cmd;
  die 'command failed' if $?;
}

sub alien_build ()
{
  my $cmake  = Alien::CMake->config('prefix') . '/bin/cmake.exe';
  my $make   = which('gmake') || which('make');
  my $system = 'MinGW Makefiles';
  _system $cmake, -G => $system, "-DCMAKE_MAKE_PROGRAM:PATH=$make", '.';
  _system $make, 'archive';
  _system $make, 'archive_static';
}

sub alien_install ()
{
  my $dir = shift @ARGV;
  print "> MD $dir\\bin\n";
  mkdir "$dir/bin";
  _system "copy", "bin\\libarchive.dll", "$dir\\bin\\libarchive.dll";
  print "> MD $dir\\lib\n";
  mkdir "$dir/lib";
  _system "copy", "libarchive\\libarchive_static.a", "$dir\\lib\\libarchive_static.a";
  _system "copy", "libarchive\\libarchive.dll.a", "$dir\\lib\\libarchive.dll.a";
  print "> MD $dir\\include\n";
  mkdir "$dir/include";
  _system "copy", "libarchive\\archive.h", "$dir\\include\\archive.h";
  _system "copy", "libarchive\\archive_entry.h", "$dir\\include\\archive_entry.h";
}

1;
