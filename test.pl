#!/usr/bin/perl

use strict;
use Test;

BEGIN { plan tests => 12 }

use Image::Imlib2;

# Does it load?
ok(1); # 1

my $image = Image::Imlib2->new(580, 100);

# Does the constructor work?
ok(defined($image), 1); #2

# Is it the right width?
ok($image->get_width, 580); #3

# Is it the right height?
ok($image->get_height, 100); #4

# Does set_colour work?
$image->set_colour(255, 0, 0, 255); 
ok(1); # 5

# Does set_color work?
$image->set_color(255, 0, 0, 255); 
ok(1); # 6

# Does draw_point work?
$image->draw_point(100, 100);
ok(1); # 7

# Does draw_line work?
$image->draw_line(50, 50, 100, 50);
ok(1); # 8

# Does draw_rectangle work?
$image->draw_rectangle(50, 50, 100, 100);
ok(1); # 9

# Does fill_rectangle work?
$image->fill_rectangle(50, 50, 100, 100);
ok(1); # 10

# Does draw_ellipse work?
$image->draw_ellipse(50, 50, 25, 25);
ok(1); # 11

# Does fill_ellipse work?
$image->fill_ellipse(50, 50, 25, 25);
ok(1); # 12

