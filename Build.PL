use Module::Build;
use strict;

# We need to find imlib2-config
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

my $libs = `$CONFIG --libs`;
my $cflags = `$CONFIG --cflags`;

my $build = Module::Build->new(
  module_name => 'Image::Imlib2',
  license     => 'perl',
  create_makefile_pl => 'passthrough',
  requires    => {
    'Test::More' => '0.01',
  },
  extra_linker_flags => $libs,
  cc_flags => $cflags,
  c_source     => './lib/Image',                                               
);
$build->create_build_script;
