#!/usr/bin/perl -w
use strict;
use Test::More tests => 18;

use_ok('Image::Imlib2');

my $image = Image::Imlib2->new(580, 200);

# Does the constructor work?
ok(defined($image));

# Is it the right width?
is($image->get_width, 580);

# Is it the right height?
is($image->get_height, 200);

# Is alpha on by default?
is($image->has_alpha, 1);

# Does set_colour work?
$image->set_colour(255, 0, 0, 255);

# Does set_color work?
$image->set_color(255, 0, 0, 255);

# Does query_pixel work?
my $p = [$image->query_pixel(10, 10)];
is_deeply($p, [0,0,0,0]);

# Does draw_point work?
$image->draw_point(10, 10);

# Does query_pixel work?
$p = [$image->query_pixel(10, 10)];
is_deeply($p, [255,0,0,255]);

# Does draw_line work?
$image->draw_line(50, 10, 100, 50);

# Does draw_rectangle work?
$image->draw_rectangle(50, 50, 100, 100);

# Does fill_rectangle work?
$image->fill_rectangle(50, 50, 100, 100);

# Does draw_ellipse work?
$image->draw_ellipse(50, 50, 25, 25);

# Does fill_ellipse work?
$image->fill_ellipse(50, 50, 25, 25);

my $cloned = $image->clone;

# Is it the right width?
is($cloned->get_width, 580);

# Is it the right height?
is($cloned->get_height, 200);

# Is alpha on by default?
is($cloned->has_alpha, 1);

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

# orientate it
$image->image_orientate(1);

# blur it
$image->blur(1);

# sharpen it
$image->sharpen(1);

# create a scaled image of it
my $dstimage = $image->create_scaled_image(100,80);

# Does has_alpha work?
$image->has_alpha(0);
is($image->has_alpha, 0);

eval { $image->not_a_method() };
isnt( $@, '', 'not_a_method() blows up' );

# since we're using use_ok, these aren't imported, so check them exactly
ok(defined(Image::Imlib2::TEXT_TO_RIGHT()), "TEXT_TO_RIGHT");
ok(defined(Image::Imlib2::TEXT_TO_LEFT()),  "TEXT_TO_LEFT");
ok(defined(Image::Imlib2::TEXT_TO_UP()),    "TEXT_TO_UP");
ok(defined(Image::Imlib2::TEXT_TO_DOWN()),  "TEXT_TO_DOWN");
ok(defined(Image::Imlib2::TEXT_TO_ANGLE()), "TEXT_TO_ANGLE");

ok(1, "got to the end")
