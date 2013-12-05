# Alien::Libarchive::MSWin32

Build and make available libarchive on MSWin32

# SYNOPSIS

    use Alien::Libarchive;

# DESCRIPTION

This distribution downloads and installs libarchive for native (non-cygwin)
Windows Perls.  You should not use this module directly, instead set
your prerequisite to [Alien::Libarchive](https://metacpan.org/pod/Alien::Libarchive), which will work on non
native Windows Perls, and will delegate to this module on native Windows.

The rationale for distributing as a separate distribution is that building
on native Windows Perls has additional configuration prerequisites that
I don't want to impose on non-Windows users of [Alien::Libarchive](https://metacpan.org/pod/Alien::Libarchive).

# CAVEATS

The build step will probably only work with a MinGW based Perl
(for example, Strawberry Perl).  Patches to fix this would be appreciated.
If you lack the expertise, contact me, I can probably help.

# SEE ALSO

- [Alien::Libarchive](https://metacpan.org/pod/Alien::Libarchive)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
