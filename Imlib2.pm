package Image::Imlib2;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(
);
$VERSION = '0.01';

bootstrap Image::Imlib2 $VERSION;

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is the stub of documentation for your module. You better edit it!

=head1 NAME

Image::Imlib2 - Interface to the Imlib2 image library

=head1 SYNOPSIS

  use Image::Imlib2;

  # create a new image
  my $image = Image::Imlib2->new(200, 200);

  # set a colour (rgba, so this is transparent orange)
  $image->set_color(255, 127, 0, 127);

  # draw a rectangle
  $image->draw_rectangle(50, 50, 50, 50);

  # draw a filled rectangle
  $image->fill_rectangle(150, 50, 50, 50);

  # draw a line
  $image->draw_line(0, 0, 200, 50);

  # save out
  $image->save('out.png');

=head1 DESCRIPTION

B<Image::Imlib2> is a Perl port of Imlib2, a graphics library that
does image file loading and saving as well as manipulation, arbitrary
polygon support, etc. It does ALL of these operations FAST. It allows
you to create colour images using a large number of graphics
primitives, and output the images in a range of formats.

Note that this is the first version of my attempt at a Perl interface
to Imlib2. Currently, the API is just to test things out. Not
everything is supported, but a great deal of functionality already
exists. If you think the API can be tweaked to be a bit more
intuitive, drop me a line!

Note that a development version of Imlib2 must be installed before
installing this module: see the README file in the Image::Imlib2
package.

=head1 METHODS

=head2 new

This will create a new, blank image. If the dimensions aren't
specified, it will default to 256 x 256.

  my $image = new Image::Imlib2->new(100, 100)

=head2 load

This will load an existing graphics file and create a new image
object. It reads quite a few different image formats.

  my $image = Image::Imlib2->load("foo.png");

=head2 save

This saves the current image out. Currently this is always in PNG
format.

  $image->save("out.png");

=head2 set_color (r, g, b, a) or set_colour (r, g, b, a)

This sets the colour that the drawing primitives will use. You specify
the red, green, blue and alpha components, which should all range from
0 to 255. The alpha component specified how transparent the colour is:
0 is fully transparent (so drawing with it will be pointless), 127 is
half-transparent, and 255 is fully opaque. Many examples:

  $image->set_colour(255, 255, 255, 255); # white
  $image->set_colour(  0,   0,   0, 255); # black
  $image->set_colour(127, 127, 127, 255); # 50% gray
  $image->set_colour(255,   0,   0, 255); # red
  $image->set_colour(  0, 255,   0, 255); # green
  $image->set_colour(  0,   0, 255, 255); # blue
  $image->set_colour(255, 127,   0, 127); # transparent orange

=head2 draw_point (x, y)

This colours a point in the image in the currently-selected
colour. Note that the coordinate system used has (0, 0) at the top
left, with (50, 0) to the right of the top left, (0, 50) below the top
left, and (50, 50) to the bottom right of the top left.

  $image->draw_point(50, 50);

=head2 draw_line (x1, y1, x2, y2)

This draws a line between two points in the currently-selected
colour. The following draws between the (0, 0) and (100, 100) points:

  $image->draw_line(0, 0, 100, 100);

=head2 draw_rectangle (x, y, w, h)

This draws a the outline of a rectangle with the top left point at (x,
y) and having width w and height h in the current colour.

  $image->draw_rectangle(0, 0, 50, 50);

=head2 fill_rectangle (x, y, w, h)

This draws a filled rectangle with the top left point at (x, y) and
having width w and height h in the current colour.

  $image->fill_rectangle(0, 0, 50, 50);

=head2 draw_ellipse (x, y, w, h)

This draws an ellipse which has center (x, y) and horizontal amplitude
of w and vertical amplitude of h in the current colour. Note that
setting w and h to the same value will draw a circle.

  $image->draw_ellipse(100, 100, 50, 50);

=head2 fill_ellipse (x, y, w, h)

This draws a filled ellipse which has center (x, y) and horizontal
amplitude of w and vertical amplitude of h in the current colour. Note
that setting w and h to the same value will draw a filled circle.

  $image->fill_ellipse(100, 100, 50, 50);

=head2 add_font_path (dir)

This function adds the directory path to the end of the current list
of directories to scan for truetype (TTF) fonts.

  $image->add_font_path("./ttfonts");

=head2 load_font (font)

This function will load a truetype font from the first directory in
the font path that contains that font. The font name format is
"font_name/size". For example. If there is a font file called cinema.ttf
somewhere in the font path you might use "cinema/20" to load a 20 pixel
sized font of cinema.

Note that this font will be used from now on, much like set_colour does
for colours.

  $image->load_font("cinema/20");

=head2 get_font_size (text)

This function returns the width and height in pixels the text string
would use up if drawn with the current font.

  my($w, $h) = $image->get_text_size("Imlib2 and Perl!");

=head2 draw_text (x, y, text)

This draws the text using the current font and colour onto the image
at position (x, y).

  $image->draw_text(50, 50, "Groovy, baby, yeah!");

=head2 crop (x, y, w, h)

This creates a duplicate of a x, y, width, height rectangle in the
current image and returns another image.

  my $cropped_image = $image->crop(0, 0, 50, 50);

=head2 blend (source_image, merge_alpha, sx, sy, sw, sh, dx, dy, dw, dh)

This will blend the source rectangle x, y, width, height from the
source_image onto the current image at the destination x, y location
scaled to the width and height specified. If merge_alpha is set to 1
it will also modify the destination image alpha channel, otherwise the
destination alpha channel is left untouched.

  $image->blend($cropped_image, 0, 0, 0, 50, 50, 200, 0, 50, 50);

=head1 AUTHOR

Leon Brocard, leon@astray.com

=head1 COPYRIGHT

Copyright (c) 2000 Leon Brocard. All rights reserved. This program is
free software; you can redistribute it and/or modify it under the same
terms as Perl itself.

=cut

