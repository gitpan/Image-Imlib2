#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <X11/Xlib.h>
#include <Imlib2.h>
#include <stdio.h>
#include <string.h>

typedef Imlib_Image Image__Imlib2;

MODULE = Image::Imlib2		PACKAGE = Image::Imlib2		PREFIX= Imlib2_

Image::Imlib2
Imlib2_new(packname="Image::Imlib2", x=256, y=256)
        char * packname
	int x
	int y

	PROTOTYPE: $;$$

        CODE:
	{
		Imlib_Image image;

		image = imlib_create_image(x, y);
		RETVAL = image;
	}
        OUTPUT:
	        RETVAL





void
Imlib2_DESTROY(image)
	Image::Imlib2	image

	PROTOTYPE: $

	CODE:
	{
		imlib_context_set_image(image);

		imlib_free_image();
	}



Image::Imlib2
Imlib2_load(packname="Image::Imlib2", filename)
        char * packname
	char * filename

	PROTOTYPE: $$

        CODE:
	{
		Imlib_Image image;

		image = imlib_load_image(filename);
		RETVAL = image;
	}
        OUTPUT:
	        RETVAL


void
Imlib2_save(image, filename)
	Image::Imlib2	image
	char * filename

	PROTOTYPE: $$

        CODE:
	{
		imlib_context_set_image(image);

		imlib_save_image(filename);
	}


int
Imlib2_get_width(image)
	Image::Imlib2	image

        PROTOTYPE: $

        CODE:
	{
		imlib_context_set_image(image);

		RETVAL = imlib_image_get_width();
	}

        OUTPUT:
                RETVAL


int
Imlib2_get_height(image)
	Image::Imlib2	image

        PROTOTYPE: $

        CODE:
	{
		imlib_context_set_image(image);

		RETVAL = imlib_image_get_height();
	}

        OUTPUT:
                RETVAL


void
Imlib2_set_color(image, r, g, b, a)
	Image::Imlib2	image
	int	r
	int 	g
	int 	b
	int 	a

	PROTOTYPE: $$$$$

        CODE:
	{
		imlib_context_set_image(image);

		imlib_context_set_color(r, g, b, a);
	}


void
Imlib2_set_colour(image, r, g, b, a)
	Image::Imlib2	image
	int	r
	int 	g
	int 	b
	int 	a

	PROTOTYPE: $$$$$

        CODE:
	{
		imlib_context_set_image(image);

		imlib_context_set_color(r, g, b, a);
	}


void
Imlib2_draw_point(image, x, y)
	Image::Imlib2	image
	int	x
	int 	y

	PROTOTYPE: $$$

        CODE:
	{
		imlib_context_set_image(image);

		imlib_image_draw_line(x, y, x, y, 0);
	}


void
Imlib2_draw_line(image, x1, y1, x2, y2)
	Image::Imlib2	image
	int	x1
	int 	y1
	int 	x2
	int 	y2

	PROTOTYPE: $$$$$

        CODE:
	{
		imlib_context_set_image(image);

		imlib_image_draw_line(x1, y1, x2, y2, 0);
	}


void
Imlib2_draw_rectangle(image, x, y, w, h)
	Image::Imlib2	image
	int	x
	int 	y
	int 	w
	int 	h

	PROTOTYPE: $$$$$

        CODE:
	{
		imlib_context_set_image(image);

		imlib_image_draw_rectangle(x, y, w, h);
	}


void
Imlib2_fill_rectangle(image, x, y, w, h)
	Image::Imlib2	image
	int	x
	int 	y
	int 	w
	int 	h

	PROTOTYPE: $$$$$

        CODE:
	{
		imlib_context_set_image(image);

		imlib_image_fill_rectangle(x, y, w, h);
	}


void
Imlib2_draw_ellipse(image, x, y, w, h)
	Image::Imlib2	image
	int	x
	int 	y
	int 	w
	int 	h

	PROTOTYPE: $$$$$

        CODE:
	{
		imlib_context_set_image(image);

		imlib_image_draw_ellipse(x, y, w, h);
	}


void
Imlib2_fill_ellipse(image, x, y, w, h)
	Image::Imlib2	image
	int	x
	int 	y
	int 	w
	int 	h

	PROTOTYPE: $$$$$

        CODE:
	{
		imlib_context_set_image(image);

		imlib_image_fill_ellipse(x, y, w, h);
	}




void
Imlib2_add_font_path(image, directory)
	Image::Imlib2	image
	char * directory

	PROTOTYPE: $$

        CODE:
	{
		imlib_context_set_image(image);

		imlib_add_path_to_font_path(directory);
	}


void
Imlib2_load_font(image, fontname)
	Image::Imlib2	image
	char * fontname

	PROTOTYPE: $$

        CODE:
	{
		Imlib_Font font;

		imlib_context_set_image(image);

		font = imlib_load_font(fontname);
		imlib_context_set_font(font);
	}


void
Imlib2_get_text_size(image, text)
	Image::Imlib2	image
	char * 	text

        PROTOTYPE: $$

	PREINIT:
		int text_w;
		int text_h;

        PPCODE:
		imlib_context_set_image(image);

		imlib_get_text_size(text, &text_w, &text_h);

		XPUSHs(sv_2mortal(newSViv(text_w)));
		XPUSHs(sv_2mortal(newSViv(text_h)));


void
Imlib2_draw_text(image, x, y, text)
	Image::Imlib2	image
	int	x
	int 	y
	char * 	text

	PROTOTYPE: $$$$

        CODE:
	{
		imlib_context_set_image(image);

		imlib_text_draw(x, y, text);
	}


Image::Imlib2
Imlib2_crop(image, x, y, w, h)
	Image::Imlib2	image
	int x
	int y
	int w
	int h

	PROTOTYPE: $$$$$

        CODE:
	{
		Imlib_Image cropped;

		imlib_context_set_image(image);

		cropped = imlib_create_cropped_image(x, y, w, h);
		RETVAL = cropped;
	}
        OUTPUT:
	        RETVAL



void
Imlib2_blend(image, source, alpha, x, y, w, h, d_x, d_y, d_w, d_h)
	Image::Imlib2	image
	Image::Imlib2	source
	int alpha
	int x
	int y
	int w
	int h
	int d_x
	int d_y
	int d_w
	int d_h

	PROTOTYPE: $$$$$$$$$$$

        CODE:
	{
		imlib_context_set_image(image);

		imlib_blend_image_onto_image(source, alpha, x, y, w, h, d_x, d_y, d_w, d_h);
	}
