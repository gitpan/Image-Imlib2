#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <X11/Xlib.h>
#include <Imlib2.h>
#include <stdio.h>
#include <string.h>

typedef Imlib_Image Image__Imlib2;
typedef ImlibPolygon Image__Imlib2__Polygon;
typedef Imlib_Color_Range Image__Imlib2__ColorRange;

static double
constant(char *name, int arg)
{
    errno = 0;
    switch (*name) {
    case 'T':
        if (strEQ(name, "TEXT_TO_RIGHT")) return IMLIB_TEXT_TO_RIGHT;
        if (strEQ(name, "TEXT_TO_LEFT")) return IMLIB_TEXT_TO_LEFT;
        if (strEQ(name, "TEXT_TO_UP")) return IMLIB_TEXT_TO_UP;
        if (strEQ(name, "TEXT_TO_DOWN")) return IMLIB_TEXT_TO_DOWN;
        if (strEQ(name, "TEXT_TO_ANGLE")) return IMLIB_TEXT_TO_ANGLE;
        break;
    }
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}  

MODULE = Image::Imlib2          PACKAGE = Image::Imlib2

double
constant(name,arg)
        char *          name
        int             arg

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
Imlib2_get_text_size(image, text, direction=IMLIB_TEXT_TO_RIGHT, angle=0)
	Image::Imlib2	image
	char * 	text
        int direction
        double  angle

        PROTOTYPE: $$

	PREINIT:
		int text_w;
		int text_h;

        PPCODE:
		imlib_context_set_image(image);
                imlib_context_set_direction(direction);
                imlib_context_set_angle(angle);

		imlib_get_text_size(text, &text_w, &text_h);

		XPUSHs(sv_2mortal(newSViv(text_w)));
		XPUSHs(sv_2mortal(newSViv(text_h)));


void
Imlib2_draw_text(image, x, y, text, direction=IMLIB_TEXT_TO_RIGHT, angle=0)
	Image::Imlib2	image
	int	x
	int 	y
	char * 	text
        int direction
        double  angle

	PROTOTYPE: $$$$;$$

        CODE:
	{
		imlib_context_set_image(image);
                imlib_context_set_direction(direction);
                imlib_context_set_angle(angle);

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


void
Imlib2_draw_polygon(image, poly, closed)
        Image::Imlib2  image
        Image::Imlib2::Polygon  poly
        unsigned char closed

        PROTOTYPE: $$$

        CODE:
        {
		imlib_context_set_image(image);

                imlib_image_draw_polygon(poly,closed);
        }

void Imlib2_fill_color_range_rectangle(image, cr, x, y, width, height, angle)
        Image::Imlib2  image
        Image::Imlib2::ColorRange cr
        int x
        int y
        int width
        int height
        double angle

        PROTOTYPE: $$$$$$

        CODE:
        {
                Imlib_Color_Range oldcr;

		imlib_context_set_image(image);
                oldcr = imlib_context_get_color_range();
                imlib_context_set_color_range(cr);
                imlib_image_fill_color_range_rectangle(x,y,width,height,angle);
                imlib_context_set_color_range(oldcr);
        }


void Imlib2_image_orientate(image, steps)
	Image::Imlib2	image
	int	steps

	PROTOTYPE: $$

        CODE:
	{
		imlib_context_set_image(image);

		imlib_image_orientate(steps);
	}


Image::Imlib2 Imlib2_create_scaled_image(image, dw, dh)
        Image::Imlib2	image
	int dw
	int dh

	PROTOTYPE: $$$

        CODE:
	{
		Imlib_Image dstimage;
		int sw, sh;

		imlib_context_set_image(image);
		sw = imlib_image_get_width();
		sh = imlib_image_get_height();

		if ( dw == 0 ) {
			dw = (int) (((double) dh * sw) / sh);
		}
		if ( dh == 0 ) {
			dh = (int) (((double) dw * sh) / sw);
		}

		dstimage = imlib_create_cropped_scaled_image(0, 0, sw, sh, dw, dh);

		RETVAL = dstimage;
	}
        OUTPUT:
	        RETVAL


MODULE = Image::Imlib2	PACKAGE = Image::Imlib2::Polygon	PREFIX= Imlib2_Polygon_

Image::Imlib2::Polygon
Imlib2_Polygon_new(packname="Image::Imlib2::Polygon")
        char * packname

	PROTOTYPE: $

        CODE:
	{
		ImlibPolygon poly;

		poly = imlib_polygon_new();
		RETVAL = poly;
	}
        OUTPUT:
	        RETVAL


void
Imlib2_Polygon_DESTROY(poly)
        Image::Imlib2::Polygon  poly

        PROTOTYPE: $

        CODE:
        {
                imlib_polygon_free(poly);
        }


void
Imlib2_Polygon_add_point(poly, x, y)
	Image::Imlib2::Polygon	poly
	int x
	int y

	PROTOTYPE: $$$

        CODE:
	{
                imlib_polygon_add_point(poly,x,y);
	}


void
Imlib2_Polygon_fill(poly)
        Image::Imlib2::Polygon  poly

        PROTOTYPE: $

        CODE:
        {
                imlib_image_fill_polygon(poly);
        }


MODULE = Image::Imlib2	PACKAGE = Image::Imlib2::ColorRange	PREFIX= Imlib2_ColorRange_

Image::Imlib2::ColorRange
Imlib2_ColorRange_new(packname="Image::Imlib2::ColorRange")
        char * packname

        PROTOTYPE: $

        CODE:
        {
                Imlib_Color_Range cr;

                cr = imlib_create_color_range();
                RETVAL = cr;
        }
        OUTPUT:
                RETVAL

void Imlib2_ColorRange_DESTROY(cr)
        Image::Imlib2::ColorRange cr

        PROTOTYPE: $

        CODE:
        {
                Imlib_Color_Range oldcr;
                oldcr = imlib_context_get_color_range();
                imlib_context_set_color_range(cr);
                imlib_free_color_range();
                imlib_context_set_color_range(oldcr);
        }

void Imlib2_ColorRange_add_color(cr, d, r, g, b, a)
        Image::Imlib2::ColorRange cr
        int d
        int r
        int g
        int b
        int a

        PROTOTYPE: $$

        CODE:
        {
                Imlib_Color_Range oldcr;
                oldcr = imlib_context_get_color_range();
                imlib_context_set_color_range(cr);
                imlib_context_set_color(r,b,g,a);
                imlib_add_color_to_color_range(d);
                imlib_context_set_color_range(oldcr);
        }

