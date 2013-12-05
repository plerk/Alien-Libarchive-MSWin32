package Alien::Libarchive::MSWin32;

use strict;
use warnings;
use base qw( Alien::Base );
use File::ShareDir qw( dist_dir );

# ABSTRACT: Build and make available libarchive on MSWin32
# VERSION

=head1 SYNOPSIS

 use Alien::Libarchive;

=head1 DESCRIPTION

This ditribution downloads and installs libarchive for native (non-cygwin)
Windows Perls.  You should not use this module directly, instead set
your prerequisite to L<Alien::Libarchive>, which will work on non
native Windows Perls, and will deligate to this module on native Windows.

The rationale for distributing as a separate distribution is that building
on native Windows Perls has additional configuration prerequisites that
I don't want to impose on non-Windows users of L<Alien::Libarchive>.

=head1 CAVEATS

The build step will probably only work with a MinGW based Perl
(for example, Strawberry Perl).  Patches to fix this would be appreciated.
If you lack the expertiese, contact me, I can probably help.

=head1 SEE ALSO

=over 4

=item L<Alien::Libarchive>

=back

=cut

sub import
{
  my $class = shift;
  $ENV{PATH} = dist_dir("Alien-Libarchive-MSWin32") . "/bin;$ENV{PATH}";
  $class->SUPER::import(@_);
}

sub cflags
{
  "-I" . dist_dir("Alien-Libarchive-MSWin32") . "/include";
}

sub libs
{
  "-L" . dist_dir("Alien-Libarchive-MSWin32") . "/lib -larchive";
}

sub dll_path
{
  dist_dir("Alien-Libarchive-MSWin32") . "bin/libarchive.dll";
}

1;
