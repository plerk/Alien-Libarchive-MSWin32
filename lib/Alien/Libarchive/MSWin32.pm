package Alien::Libarchive::MSWin32;

use strict;
use warnings;
use base qw( Alien::Base );
use File::ShareDir qw( dist_dir );

# ABSTRACT: Build and make available libarchive on MSWin32
# VERSION

sub cflags
{
  "-I" . dist_dir("Alien-Libarchive-MSWin32") . "/include";
}

sub libs
{
  "-L" . dist_dir("Alien-Libarchive-MSWin32") . "/lib -larchive";
}

1;
