use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'Image::Imlib2',
    'VERSION_FROM' => 'Imlib2.pm', # finds $VERSION
    'LIBS'	=> [split /\s+/, `imlib2-config --libs`],   # e.g., '-lm' 
    'INC'	=> `imlib2-config --cflags`,     # e.g., '-I/usr/include/other' 
    'dist' => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
);
