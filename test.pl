#!/usr/bin/perl

use strict;
use Test;

BEGIN { plan tests => 13 }

use Image::Imlib2;

# Does it load?
ok(1); # 1

my $image = Image::Imlib2->new(580, 200);

# Does the constructor work?
ok(defined($image), 1); #2

# Is it the right width?
ok($image->get_width, 580); #3

# Is it the right height?
ok($image->get_height, 200); #4

# Does set_colour work?
$image->set_colour(255, 0, 0, 255); 
ok(1); # 5

# Does set_color work?
$image->set_color(255, 0, 0, 255); 
ok(1); # 6

# Does draw_point work?
$image->draw_point(10, 10);
ok(1); # 7

# Does draw_line work?
$image->draw_line(50, 10, 100, 50);
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

# create a polygon
my $poly = Image::Imlib2::Polygon->new();

# add some points
$poly->add_point(10, 3);
$poly->add_point(0, 7);
$poly->add_point(10, 20);
$poly->add_point(10, 3);

# fill the polygon
$poly->fill();

# draw it closed on image
$image->draw_polygon($poly, 1);

ok(1); # 13 coo, polygons, work
