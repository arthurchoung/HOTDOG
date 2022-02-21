#import "HOTDOG.h"

@implementation Definitions(jfklewfklmdklsfmklsdmkfcvijiowe)
+ (id)VIBitmap
{
    id bitmap = [Definitions ppmFromStandardInput];
    if (!bitmap) {
        return nil;
    }
    int w = [bitmap bitmapWidth];
    int h = [bitmap bitmapHeight];
    id obj = [@"VIBitmap" asInstance];
    [obj setValue:bitmap forKey:@"bitmap"];
    [obj setValue:nsfmt(@"%d", w) forKey:@"width"];
    [obj setValue:nsfmt(@"%d", h) forKey:@"height"];
    return obj;
}
+ (id)ppmFromStandardInput
{
    id data = [Definitions dataFromStandardInput];
NSLog(@"data %@", data);
    if (!data) {
        return nil;
    }
    unsigned char *a = [data bytes];
    int len = [data length];
    unsigned char *end = a + len;

    if ((len >= 2) && (a[0] == 'P') && (a[1] == '6')) {
    } else {
NSLog(@"unsupported, expecting P6");
        return nil;
    }

    if ((len >= 3) && (a[2] == '\n')) {
    } else {
NSLog(@"expecting newline");
        return nil;
    }

    if (len-3 <= 1) {
NSLog(@"not enough data");
        return nil;
    }
    unsigned char *b = memchr(a+3, ' ', len-3);
    if (!b) {
NSLog(@"expecting space");
        return nil;
    }
    *b = 0;
    b++;
    int w = strtol(a+3, NULL, 10);

    if (len-(b-a) <= 1) {
NSLog(@"not enough data");
        return nil;
    }
    unsigned char *c = memchr(b, '\n', len-(b-a));
    if (!c) {
NSLog(@"expecting newline");
        return nil;
    }
    *c = 0;
    c++;
    int h = strtol(b, NULL, 10);

    if (len-(c-a) <= 1) {
NSLog(@"not enough data");
        return nil;
    }
    unsigned char *d = memchr(c, '\n', len-(c-a));
    if (!d) {
NSLog(@"expecting newline");
        return nil;
    }
    *d = 0;
    d++;
    int maxval = strtol(c, NULL, 10);

    int index = d - a;
NSLog(@"index %d w %d h %d maxval %d", index, w, h, maxval);

    if (maxval == 255) {
        if (index+(w*h*3) == len) {
        } else {
NSLog(@"invalid length");
            return nil;
        }
        id bitmap = [Definitions bitmapWithWidth:w height:h];
        unsigned char *pixels = [bitmap pixelBytes];
        for (int y=0; y<h; y++) {
            for (int x=0; x<w; x++) {
                pixels[0] = d[2];
                pixels[1] = d[1];
                pixels[2] = d[0];
                pixels[3] = 255;
                pixels += 4;
                d += 3;
            }
        }
        return bitmap;
    } else if (maxval == 65535) {
        if (index+(w*h*6) == len) {
        } else {
NSLog(@"invalid length");
            return nil;
        }
        id bitmap = [Definitions bitmapWithWidth:w height:h];
        unsigned char *pixels = [bitmap pixelBytes];
        for (int y=0; y<h; y++) {
            for (int x=0; x<w; x++) {
                pixels[0] = d[4];
                pixels[1] = d[2];
                pixels[2] = d[0];
                pixels[3] = 255;
                pixels += 4;
                d += 6;
            }
        }
        return bitmap;
    } else {
NSLog(@"unsupported maxval %d", maxval);
        return nil;
    }
}
@end


@interface VIBitmap : IvarObject
{
    id _path;
    id _bitmap;
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

    char *bytes = [_bitmap pixelBytes];
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

