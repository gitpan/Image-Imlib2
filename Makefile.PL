use ExtUtils::MakeMaker;
use strict;

# We need to find  imlib2-config
my $CONFIG = "imlib2-config";

my $version = `$CONFIG --version`;
if (!$version) {
  warn 'You must install the imlib2 library before you can install
Image::Imlib2. You can obtain imlib2 from
http://sourceforge.net/projects/enlightenment/

Alternatively, if you have downloaded and installed imlib2 and this
still will not work, modify the $CONFIG variable inside Makefile.PL to
point to the imlib2-config program that provides.
';
  exit;
} else {
  print "Found imlib2 $version";
}

WriteMakefile(
    'NAME'	=> 'Image::Imlib2',
    'VERSION_FROM' => 'Imlib2.pm', # finds $VERSION
    'LIBS'	=> [split /\s+/, `$CONFIG --libs`], 
    'INC'	=> `$CONFIG --cflags`,     # e.g., 
    'dist' => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
);
