/*

 HOTDOG

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- hotdogpucko.com

 This file is part of HOTDOG.

 HOTDOG is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.

 */

#import "HOTDOG.h"

static unsigned char *bitmapDefaultButtonLeftPixels =
"     bbb\n"
"   bbbbb\n"
"  bbbbbb\n"
" bbbbwww\n"
" bbbwwwb\n"
"bbbwwbb.\n"
"bbbwwb..\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwwb..\n"
"bbbwwbb.\n"
" bbbwwwb\n"
" bbbbwww\n"
"  bbbbbb\n"
"   bbbbb\n"
"     bbb\n"
;
static unsigned char *bitmapDefaultButtonMiddlePixels =
"b\n"
"b\n"
"b\n"
"w\n"
"b\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
"b\n"
"w\n"
"b\n"
"b\n"
"b\n"
;
static unsigned char *bitmapDefaultButtonRightPixels =
"bbb     \n"
"bbbbb   \n"
"bbbbbb  \n"
"wwwbbbb \n"
"bwwwbbb \n"
".bbwwbbb\n"
"..bwwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"..bwwbbb\n"
".bbwwbbb\n"
"bwwwbbb \n"
"wwwbbbb \n"
"bbbbbb  \n"
"bbbbb   \n"
"bbb     \n"
;
static void drawDefaultButtonInBitmap_rect_palette_(id bitmap, Int4 r, unsigned char *palette)
{
    unsigned char *left = bitmapDefaultButtonLeftPixels;
    unsigned char *middle = bitmapDefaultButtonMiddlePixels;
    unsigned char *right = bitmapDefaultButtonRightPixels;

    [Definitions drawInBitmap:bitmap left:left middle:middle right:right centeredInRect:r palette:palette];
}



static void drawAlertBorderInBitmap_rect_(id bitmap, Int4 r)
{
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    unsigned char *pixels = [bitmap pixelBytes];
    if (!pixels) {
        return;
    }
    int bitmapWidth = [bitmap bitmapWidth];
    int bitmapHeight = [bitmap bitmapHeight];
    int bitmapStride = [bitmap bitmapStride];
    for (int i=0; i<bitmapWidth; i++) {
        unsigned char *p = pixels + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=3; i<bitmapWidth-3; i++) {
        unsigned char *p = pixels + bitmapStride*3 + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=4; i<bitmapWidth-4; i++) {
        unsigned char *p = pixels + bitmapStride*4 + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }

    for (int i=0; i<bitmapWidth; i++) {
        unsigned char *p = pixels + bitmapStride*(bitmapHeight-1) + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=3; i<bitmapWidth-3; i++) {
        unsigned char *p = pixels + bitmapStride*(bitmapHeight-1-3) + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=4; i<bitmapWidth-4; i++) {
        unsigned char *p = pixels + bitmapStride*(bitmapHeight-1-4) + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }

    for (int i=1; i<bitmapHeight-1; i++) {
        unsigned char *p = pixels + bitmapStride*i + 0;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=1; i<bitmapHeight-1; i++) {
        unsigned char *p = pixels + bitmapStride*i + (bitmapWidth-1)*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=4; i<bitmapHeight-4; i++) {
        unsigned char *p = pixels + bitmapStride*i + 3*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=4; i<bitmapHeight-4; i++) {
        unsigned char *p = pixels + bitmapStride*i + (bitmapWidth-1-3)*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=5; i<bitmapHeight-5; i++) {
        unsigned char *p = pixels + bitmapStride*i + 4*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=5; i<bitmapHeight-5; i++) {
        unsigned char *p = pixels + bitmapStride*i + (bitmapWidth-1-4)*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }

}

@implementation Definitions(fjkldsjfkldjslkfjkldsjfk)
+ (char *)cStringForBitmapErrorIcon
{
    return
"........bbbbbbbbbbbbbbbb........\n"
".......bbbbbbbbbbbbbbbbbb.......\n"
"......bbbbbbbbbbbbbbbbbbbb......\n"
".....bbbbbbbbbb.bbbbbbbbbbb.....\n"
"....bbbbbbbbbb...bbbbbbbbbbb....\n"
"...bbbbbbbb.bb...bb..bbbbbbbb...\n"
"..bbbbbbbb...b...b...bbbbbbbbb..\n"
".bbbbbbbbb...b...b...bbbbbbbbbb.\n"
"bbbbbbbb.b...b...b...bbbbbbbbbbb\n"
"bbbbbbb..b...b...b...bbbbbbbbbbb\n"
"bbbbbbb..b...b...b...bbbbbbbbbbb\n"
"bbbbbbb..b...b...b...bbbbbbbbbbb\n"
"bbbbbbb..b...b...b...bbbbbbbbbbb\n"
"bbbbbbb..b...b...b...bbbbbbbbbbb\n"
"bbbbbbb..b...........bbb...bbbbb\n"
"bbbbbbb..............bb....bbbbb\n"
"bbbbbbb..............bb....bbbbb\n"
"bbbbbbb..............b....bbbbbb\n"
"bbbbbbb...................bbbbbb\n"
"bbbbbbb..................bbbbbbb\n"
"bbbbbbb..................bbbbbbb\n"
"bbbbbbb.................bbbbbbbb\n"
"bbbbbbb.................bbbbbbbb\n"
"bbbbbbb................bbbbbbbbb\n"
"bbbbbbb................bbbbbbbbb\n"
".bbbbbb......b........bbbbbbbbb.\n"
"..bbbbbb......b......bbbbbbbbb..\n"
"...bbbbbbbbbbbbbbbbbbbbbbbbbb...\n"
"....bbbbbbbbbbbbbbbbbbbbbbbb....\n"
".....bbbbbbbbbbbbbbbbbbbbbb.....\n"
"......bbbbbbbbbbbbbbbbbbbb......\n"
".......bbbbbbbbbbbbbbbbbb.......\n"
;
}
@end

@implementation Definitions(jfldslkfjdslkjjfklewjkfjslkdf)
+ (int)preferredHeightForBitmapErrorAlert:(id)text width:(int)width
{
    int textWidth = width - 119 - 28;
    id fittedText = [Definitions fitBitmapString:text width:textWidth];

    int minAlertHeight = 18 + 32 + 13 + 28 + 15;
    int textHeight = [Definitions bitmapHeightForText:fittedText];
    int alertHeight = 21 + textHeight + 1 + 28 + 15;
    if (alertHeight < minAlertHeight) {
        alertHeight = minAlertHeight;
    }
    return alertHeight;
}
@end
@interface BitmapErrorAlert : IvarObject
{
    BOOL _mouseDown;
    id _text;
}
@end
@implementation BitmapErrorAlert
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    drawAlertBorderInBitmap_rect_(bitmap, r);
    char *bitmapErrorIcon = [Definitions cStringForBitmapErrorIcon];
    char *palette = "b #000000\n. #ffffff\n";
    [bitmap drawCString:bitmapErrorIcon palette:palette x:40 y:18];

    Int4 buttonRect = [Definitions rectWithX:24 y:r.h-15-28 w:68 h:28];
    if (_mouseDown) {
        char *palette = ". #000000\nb #000000\n";
        drawDefaultButtonInBitmap_rect_palette_(bitmap, buttonRect, palette);
        [bitmap setColorIntR:255 g:255 b:255 a:255];
        [bitmap drawBitmapText:@"OK" centeredInRect:buttonRect];
    } else {
        char *palette = ". #ffffff\nb #000000\n";
        drawDefaultButtonInBitmap_rect_palette_(bitmap, buttonRect, palette);
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:@"OK" centeredInRect:buttonRect];
    }

    [bitmap setColor:@"black"];
    int textWidth = (int)r.w - 119 - 28;
    id text = [bitmap fitBitmapString:_text width:textWidth];
    [bitmap setColorIntR:0 g:0 b:0 a:255];
    [bitmap drawBitmapText:text x:119 y:21];
    // 28 pixels right margin
}
- (void)handleMouseDown:(id)event
{
    _mouseDown = YES;
}
- (void)handleMouseUp:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];
    [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
}
@end
@implementation NSString(fjlkdslkjfsdjfjkdlsjfkldsjkf)
- (id)asBitmapErrorAlert
{
    id obj = [@"BitmapErrorAlert" asInstance];
    [obj setValue:self forKey:@"text"];
    return obj;
}
@end
