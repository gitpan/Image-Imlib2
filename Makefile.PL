use strict;
use ExtUtils::MakeMaker;

if (eval "use Module::Build::Compat 0.02; 1" ) {
  Module::Build::Compat->run_build_pl(args => \@ARGV);
  Module::Build::Compat->write_makefile();
} else {
  print "This module requires Module::Build to install itself.\n";
  print "Please install Module::Build and run:\n";
  print "perl Build.PL; ./Build; ./Build test; ./Build install\n";

  WriteMakefile(
    'NAME'	=> 'Image::Imlib2',
    'VERSION_FROM' => 'lib/Image/Imlib2.pm', # finds $VERSION
    'PREREQ_PM' => {'Test::More' => 0.01, 'Module::Build' => 0.01 },
  );
}
