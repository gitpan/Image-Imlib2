#!/usr/local/bin/perl
#
# This is a program which attempts to produce a picture
# I once saw by John Maeda.
#
# Leon Brocard

use strict;
use lib '.';
use Image::Imlib2;
use POSIX qw(floor);

my $image = Image::Imlib2->new(640, 480);

$image->set_colour(255, 255, 255, 255);
$image->fill_rectangle(0, 0, 640, 480);

foreach my $x (0..640) {

  next if ($x + 16) % 32;

  $x += rand(16) - 8;

  my $h = $x / 2;
  $h = 320 - $h if $h > 160;
  $h *= 2;

  foreach my $c (1..$h/4) {

    my $rand = floor(rand(4));
    
    if ($rand == 0) {
      $image->set_colour(255, 255,   0, 255);
    } elsif ($rand == 1) {
      $image->set_colour(255,   0, 255, 255);
    } elsif ($rand == 2) {
      $image->set_colour(  0, 255, 255, 255);
    } elsif ($rand == 3) {
      $image->set_colour(  0,   0,   0, 255);
    }

    my $y = 240 + rand($h) - ($h / 2) + rand(80) - 40;
    
    my $radius = int(rand(10)) + 1;
    $image->fill_ellipse($x, $y, $radius, $radius);

  }

}

$image->save("maeda.png");
