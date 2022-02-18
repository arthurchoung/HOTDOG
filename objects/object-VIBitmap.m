#import "HOTDOG.h"

/* example.c - an example of using libpng
 * Last changed in libpng 1.6.24 [August 4, 2016]
 * Maintained 1998-2016 Glenn Randers-Pehrson
 * Maintained 1996, 1997 Andreas Dilger)
 * Written 1995, 1996 Guy Eric Schalnat, Group 42, Inc.)
 * To the extent possible under law, the authors have waived
 * all copyright and related or neighboring rights to this file.
 * This work is published from: United States.
 */

/* This is an example of how to use libpng to read and write PNG files.
 * The file libpng-manual.txt is much more verbose then this.  If you have not
 * read it, do so first.  This was designed to be a starting point of an
 * implementation.  This is not officially part of libpng, is hereby placed
 * in the public domain, and therefore does not require a copyright notice.
 *
 * This file does not currently compile, because it is missing certain
 * parts, like allocating memory to hold an image.  You will have to
 * supply these parts to get it to compile.  For an example of a minimal
 * working PNG reader/writer, see pngtest.c, included in this distribution;
 * see also the programs in the contrib directory.
 */

/* The simple, but restricted, approach to reading a PNG file or data stream
 * just requires two function calls, as in the following complete program.
 * Writing a file just needs one function call, so long as the data has an
 * appropriate layout.
 *
 * The following code reads PNG image data from a file and writes it, in a
 * potentially new format, to a new file.  While this code will compile there is
 * minimal (insufficient) error checking; for a more realistic version look at
 * contrib/examples/pngtopng.c
 */
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "png.h"
#include <zlib.h>

static unsigned char *read_png_from_file(char *path)
{
    png_image image; /* The control structure used by libpng */

    /* Initialize the 'png_image' structure. */
    memset(&image, 0, (sizeof image));
    image.version = PNG_IMAGE_VERSION;

    /* The first argument is the file to read: */
    if (png_image_begin_read_from_file(&image, path) == 0) {
        fprintf(stderr, "pngtopng: error: %s\n", image.message);
        return NULL;
    }

    png_bytep buffer;

    /* Set the format in which to read the PNG file; this code chooses a
     * simple sRGB format with a non-associated alpha channel, adequate to
     * store most images.
     */
    image.format = PNG_FORMAT_RGBA;

    /* Now allocate enough memory to hold the image in this format; the
     * PNG_IMAGE_SIZE macro uses the information about the image (width,
     * height and format) stored in 'image'.
     */
    int buffer_length = PNG_IMAGE_SIZE(image);
    buffer = malloc(buffer_length);

    /* If enough memory was available read the image in the desired format
     * then write the result out to the new file.  'background' is not
     * necessary when reading the image because the alpha channel is
     * preserved; if it were to be removed, for example if we requested
     * PNG_FORMAT_RGB, then either a solid background color would have to
     * be supplied or the output buffer would have to be initialized to the
     * actual background of the image.
     *
     * The fourth argument to png_image_finish_read is the 'row_stride' -
     * this is the number of components allocated for the image in each
     * row.  It has to be at least as big as the value returned by
     * PNG_IMAGE_ROW_STRIDE, but if you just allocate space for the
     * default, minimum, size using PNG_IMAGE_SIZE as above you can pass
     * zero.
     *
     * The final argument is a pointer to a buffer for the colormap;
     * colormaps have exactly the same format as a row of image pixels (so
     * you choose what format to make the colormap by setting
     * image.format).  A colormap is only returned if
     * PNG_FORMAT_FLAG_COLORMAP is also set in image.format, so in this
     * case NULL is passed as the final argument.  If you do want to force
     * all images into an index/color-mapped format then you can use:
     *
     *    PNG_IMAGE_COLORMAP_SIZE(image)
     *
     * to find the maximum size of the colormap in bytes.
     */
    if (buffer != NULL &&
            png_image_finish_read(&image, NULL/*background*/, buffer,
                0/*row_stride*/, NULL/*colormap*/) != 0)
    {
        for (int i=0; i<buffer_length; i+=4) {
            unsigned char *p = buffer;
            p += i;
            unsigned char temp = p[0];
            p[0] = p[2];
            p[2] = temp;
        }
        id obj = [@"VIBitmap" asInstance];
        [obj setValue:nsfmt(@"%s", path) forKey:@"path"];
        [obj setValue:[NSData dataWithBytesNoCopy:buffer length:buffer_length] forKey:@"data"];
        [obj setValue:nsfmt(@"%d", image.width) forKey:@"width"];
        [obj setValue:nsfmt(@"%d", image.height) forKey:@"height"];
        return obj;
    }

    else
    {
        /* Calling png_free_image is optional unless the simplified API was
         * not run to completion.  In this case if there wasn't enough
         * memory for 'buffer' we didn't complete the read, so we must free
         * the image:
         */
        if (buffer == NULL)
            png_image_free(&image);

        else
            free(buffer);
    }

    return NULL;
}

/* That's it ;-)  Of course you probably want to do more with PNG files than
 * just converting them all to 32-bit RGBA PNG files; you can do that between
 * the call to png_image_finish_read and png_image_write_to_file.  You can also
 * ask for the image data to be presented in a number of different formats.  You
 * do this by simply changing the 'format' parameter set before allocating the
 * buffer.
 *
 * The format parameter consists of five flags that define various aspects of
 * the image, you can simply add these together to get the format or you can use
 * one of the predefined macros from png.h (as above):
 *
 * PNG_FORMAT_FLAG_COLOR: if set the image will have three color components per
 *    pixel (red, green and blue), if not set the image will just have one
 *    luminance (grayscale) component.
 *
 * PNG_FORMAT_FLAG_ALPHA: if set each pixel in the image will have an additional
 *    alpha value; a linear value that describes the degree the image pixel
 *    covers (overwrites) the contents of the existing pixel on the display.
 *
 * PNG_FORMAT_FLAG_LINEAR: if set the components of each pixel will be returned
 *    as a series of 16-bit linear values, if not set the components will be
 *    returned as a series of 8-bit values encoded according to the 'sRGB'
 *    standard.  The 8-bit format is the normal format for images intended for
 *    direct display, because almost all display devices do the inverse of the
 *    sRGB transformation to the data they receive.  The 16-bit format is more
 *    common for scientific data and image data that must be further processed;
 *    because it is linear simple math can be done on the component values.
 *    Regardless of the setting of this flag the alpha channel is always linear,
 *    although it will be 8 bits or 16 bits wide as specified by the flag.
 *
 * PNG_FORMAT_FLAG_BGR: if set the components of a color pixel will be returned
 *    in the order blue, then green, then red.  If not set the pixel components
 *    are in the order red, then green, then blue.
 *
 * PNG_FORMAT_FLAG_AFIRST: if set the alpha channel (if present) precedes the
 *    color or grayscale components.  If not set the alpha channel follows the
 *    components.
 *
 * You do not have to read directly from a file.  You can read from memory or,
 * on systems that support it, from a <stdio.h> FILE*.  This is controlled by
 * the particular png_image_read_from_ function you call at the start.  Likewise
 * on write you can write to a FILE* if your system supports it.  Check the
 * macro PNG_STDIO_SUPPORTED to see if stdio support has been included in your
 * libpng build.
 *
 * If you read 16-bit (PNG_FORMAT_FLAG_LINEAR) data you may need to write it in
 * the 8-bit format for display.  You do this by setting the convert_to_8bit
 * flag to 'true'.
 *
 * Don't repeatedly convert between the 8-bit and 16-bit forms.  There is
 * significant data loss when 16-bit data is converted to the 8-bit encoding and
 * the current libpng implementation of conversion to 16-bit is also
 * significantly lossy.  The latter will be fixed in the future, but the former
 * is unavoidable - the 8-bit format just doesn't have enough resolution.
 */


@implementation NSString(fjkdslkfj)
- (id)pngFromFile
{
    return read_png_from_file([self UTF8String]);
}
@end

@interface VIBitmap : IvarObject
{
    id _path;
    id _data;
    int _width;
    int _height;
    Int4 _rect;
    int _mouseMovedX;
    int _mouseMovedY;
    BOOL _mouseDown;
    int _mouseDownX;
    int _mouseDownY;
    BOOL _mouseUp;
    int _mouseUpX;
    int _mouseUpY;
}
@end
@implementation VIBitmap

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColor:@"black"];
    [bitmap fillRect:r];

    _rect = r;

    char *bytes = [_data bytes];
    if (!bytes) {
        return;
    }

    int w = r.w;
    int h = r.h;

    [bitmap drawBytes:bytes bitmapWidth:_width bitmapHeight:_height x:r.x y:r.y w:_width h:_height];

    [bitmap setColorDoubleR:1 g:1 b:1 a:0.5];
    if (_mouseUp) {
        [bitmap drawLineAtX:_mouseUpX y:0 x:_mouseUpX y:h];
        [bitmap drawLineAtX:0 y:_mouseUpY x:w y:_mouseUpY];
    } else {
        [bitmap drawLineAtX:_mouseMovedX y:0 x:_mouseMovedX y:h];
        [bitmap drawLineAtX:0 y:_mouseMovedY x:w y:_mouseMovedY];
    }
    if (_mouseDown) {
        [bitmap drawLineAtX:_mouseDownX y:0 x:_mouseDownX y:h];
        [bitmap drawLineAtX:0 y:_mouseDownY x:w y:_mouseDownY];
        if (_mouseUp) {
            [bitmap setColorDoubleR:1 g:1 b:1 a:0.25];
            [bitmap fillRectangleAtX:_mouseDownX y:_mouseDownY x:_mouseUpX y:_mouseUpY];
            [bitmap setColorDoubleR:1 g:1 b:1 a:0.5];
            [bitmap drawRectangleAtX:_mouseDownX y:_mouseDownY x:_mouseUpX y:_mouseUpY];
        } else {
            [bitmap setColorDoubleR:1 g:1 b:1 a:0.25];
            [bitmap fillRectangleAtX:_mouseDownX y:_mouseDownY x:_mouseMovedX y:_mouseMovedY];
            [bitmap setColorDoubleR:1 g:1 b:1 a:0.5];
            [bitmap drawRectangleAtX:_mouseDownX y:_mouseDownY x:_mouseMovedX y:_mouseMovedY];
        }
    }
    [bitmap setColorIntR:0 g:0 b:255 a:255];
    [bitmap drawBitmapText:nsfmt(@"mouseMoved x %f y %f", _mouseMovedX, _mouseMovedY) x:5 y:5];
    [bitmap drawBitmapText:nsfmt(@"width %d height %d", _width, _height) x:5 y:20];
}
- (void)handleMouseDown:(id)event
{
    _mouseDown = YES;
    _mouseUp = NO;
    _mouseDownX = [event intValueForKey:@"mouseX"];
    _mouseDownY = [event intValueForKey:@"mouseY"];
}

- (void)handleMouseUp:(id)event
{
    _mouseUp = YES;
    _mouseUpX = [event intValueForKey:@"mouseX"];
    _mouseUpY = [event intValueForKey:@"mouseY"];
}

- (void)handleMouseMoved:(id)event
{
    _mouseMovedX = [event intValueForKey:@"mouseX"];
    _mouseMovedY = [event intValueForKey:@"mouseY"];
}

- (id)crop
{
    int x1, y1, x2, y2, temp;
    x1 = _mouseDownX*_width;
    y1 = _height - _mouseDownY*_height;
    x2 = _mouseUpX*_width;
    y2 = _height - _mouseUpY*_height;
    if (x2 < x1) {
        temp = x1;
        x1 = x2;
        x2 = temp;
    }
    if (y2 < y1) {
        temp = y1;
        y1 = y2;
        y2 = temp;
    }
    id outputPath = [Definitions execDir:@"Temp/crop.jpg"];
    id arr = nsarr();
    [arr addObject:@"convert"];
    [arr addObject:_path];
    [arr addObject:@"-crop"];
    [arr addObject:nsfmt(@"%dx%d%+d%+d", (int)(x2-x1), (int)(y2-y1), (int)x1, (int)y1)];
    [arr addObject:outputPath];
    NSLog(@"crop %@", arr);
    [arr runCommandAndReturnOutput];
    return [outputPath jpegFromFile];
}
- (id)drawBlackRectangle
{
    Int2 proportionalSize = [Definitions proportionalSizeForWidth:_rect.w height:_rect.h origWidth:_width origHeight:_height];
    Int4 centeredRect = [Definitions centerRectX:0 y:0 w:proportionalSize.w h:proportionalSize.h inW:_rect.w h:_rect.h];

    double x1pct = (_mouseDownX-centeredRect.x)/centeredRect.w;
    double y1pct = 1.0-((_mouseDownY-centeredRect.y)/centeredRect.h);
    double x2pct = (_mouseUpX-centeredRect.x)/centeredRect.w;
    double y2pct = 1.0-((_mouseUpY-centeredRect.y)/centeredRect.h);
    if (x1pct < 0.0) x1pct = 0.0;
    if (y1pct < 0.0) y1pct = 0.0;
    if (x2pct < 0.0) x2pct = 0.0;
    if (y2pct < 0.0) y2pct = 0.0;
    if (x1pct > 1.0) x1pct = 1.0;
    if (y1pct > 1.0) y1pct = 1.0;
    if (x2pct > 1.0) x2pct = 1.0;
    if (y2pct > 1.0) y2pct = 1.0;

    int x1, y1, x2, y2, temp;
    x1 = x1pct*_width;
    y1 = y1pct*_height;
    x2 = x2pct*_width;
    y2 = y2pct*_height;
    if (x2 < x1) {
        temp = x1;
        x1 = x2;
        x2 = temp;
    }
    if (y2 < y1) {
        temp = y1;
        y1 = y2;
        y2 = temp;
    }
    id outputPath = [Definitions execDir:@"Temp/crop.jpg"];
    id arr = nsarr();
    [arr addObject:@"convert"];
    [arr addObject:_path];
    [arr addObject:@"-fill"];
    [arr addObject:@"black"];
    [arr addObject:@"-draw"];
    [arr addObject:nsfmt(@"rectangle %d,%d %d,%d", (int)x1, (int)(y1), (int)x2, (int)(y2))];
    [arr addObject:outputPath];
    NSLog(@"draw black rectangle%@", arr);
    [arr runCommandAndReturnOutput];
    return [outputPath jpegFromFile];
}

@end

