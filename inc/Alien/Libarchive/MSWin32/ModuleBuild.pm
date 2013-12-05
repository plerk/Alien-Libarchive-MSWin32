package Alien::Libarchive::MSWin32::ModuleBuild;

use strict;
use warnings;
use Alien::CMake;
use base qw( Alien::Base::ModuleBuild );

sub new
{
  my($class, %args) = @_;
  
  my $cmake = Alien::CMake->config('prefix') . '/bin/cmake.exe';
  
  foreach my $phase (grep /^alien_.*_commands$/ keys %args)
  {
    print "\n$phase:\n";    
    for(@{ $args{$phase} })
    {
      # $cmake, location of CMAKE
      s/\$cmake/$cmake/ge;
      # $make, location of MAKE
      s/\$make/$make/ge;
      # $system, target platform
      s/\$system/MinGW Makefiles/ge;
      print "  $_\n";
    }
    print "\n";
    
  }
  
  $class->SUPER::new(%args);
}

sub libs
{
  '';
}

sub cflags
{
  '';
}

1;
