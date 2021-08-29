/*

 HOT DOG Linux

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- hotdoglinux.com

 This file is part of HOT DOG Linux.

 HOT DOG Linux is free software: you can redistribute it and/or modify
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

#include <sys/time.h>

@implementation Definitions(fjeiwofmkdsomvklcxjvlksjdfkjds)
+ (char *)cStringForAmigaHorizontalScrollBarLeft
{
    return
"ooooooooooooooo\n"
"bbbbbbbbbbbbbbb\n"
"ooooXXXooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"ooXXXooooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"XXXooooooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"XXXXXXXXXXXooXX\n"
"bbbbbbbbbbbbbbb\n"
"XXXooooooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"ooXXXooooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"ooooXXXooooooXX\n"
"bbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaHorizontalScrollBarMiddle
{
    return
"o\n"
"b\n"
"X\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"X\n"
"b\n"
;
}
+ (char *)cStringForAmigaHorizontalScrollBarRight
{
    return
"ooooooooooooooo\n"
"bbbbbbbbbbbbbbb\n"
"XXoooooooXXXooo\n"
"bbbbbbbbbbbbbbb\n"
"XXoooooooooXXXo\n"
"bbbbbbbbbbbbbbb\n"
"XXoooooooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"XXooXXXXXXXXXXX\n"
"bbbbbbbbbbbbbbb\n"
"XXoooooooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"XXoooooooooXXXo\n"
"bbbbbbbbbbbbbbb\n"
"XXoooooooXXXooo\n"
"bbbbbbbbbbbbbbb\n"
;
}
+ (void)drawAmigaHorizontalScrollBarInBitmap:(id)bitmap x:(int)x0 y:(int)y0 w:(int)w
{
    char *palette = [Definitions cStringForAmigaPalette];

    char *left = [Definitions cStringForAmigaHorizontalScrollBarLeft];
    char *middle = [Definitions cStringForAmigaHorizontalScrollBarMiddle];
    char *right = [Definitions cStringForAmigaHorizontalScrollBarRight];

    int widthForLeft = [Definitions widthForCString:left];
    int widthForMiddle = [Definitions widthForCString:middle];
    int widthForRight = [Definitions widthForCString:right];

    int heightForMiddle = [Definitions heightForCString:middle];

    [bitmap drawCString:left palette:palette x:x0 y:y0];
    int x;
    for (x=x0+widthForLeft; x<x0+w-widthForRight; x+=widthForMiddle) {
        [bitmap drawCString:middle palette:palette x:x y:y0];
    }
    [bitmap drawCString:right palette:palette x:x0+w-widthForRight y:y0];
}
+ (char *)cStringForAmigaFuelGaugeTop
{
    return
"............oo\n"
"bbbbbbbbbbbbbb\n"
"...oooooo...oo\n"
"bbbbbbbbbbbbbb\n"
"...oo.......oo\n"
"bbbbbbbbbbbbbb\n"
"...oooo.....oo\n"
"bbbbbbbbbbbbbb\n"
"...oo.......oo\n"
"bbbbbbbbbbbbbb\n"
"...oo.......oo\n"
"bbbbbbbbbbbbbb\n"
"............oo\n"
"bbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaFuelGaugeMiddle
{
    return
"************oo\n"
"bbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaFuelGaugeBottom
{
    return
"............oo\n"
"bbbbbbbbbbbbbb\n"
"...oooooo...oo\n"
"bbbbbbbbbbbbbb\n"
"...oo.......oo\n"
"bbbbbbbbbbbbbb\n"
"...oooo.....oo\n"
"bbbbbbbbbbbbbb\n"
"...oo.......oo\n"
"bbbbbbbbbbbbbb\n"
"...oooooo...oo\n"
"bbbbbbbbbbbbbb\n"
"............oo\n"
"bbbbbbbbbbbbbb\n"
;
}
+ (void)drawAmigaFuelGaugeInBitmap:(id)bitmap x:(int)x0 y:(int)y0 h:(int)h
{
    char *palette = [Definitions cStringForAmigaPalette];

    char *top = [Definitions cStringForAmigaFuelGaugeTop];
    char *middle = [Definitions cStringForAmigaFuelGaugeMiddle];
    char *bottom = [Definitions cStringForAmigaFuelGaugeBottom];

    int heightForTop = [Definitions heightForCString:top];
    int heightForMiddle = [Definitions heightForCString:middle];
    int heightForBottom = [Definitions heightForCString:bottom];

    int widthForMiddle = [Definitions widthForCString:middle];

    [bitmap drawCString:top palette:palette x:x0 y:y0];
    for (int y=y0+heightForTop; y<y0+h-heightForBottom; y+=heightForMiddle) {
        [bitmap drawCString:middle palette:palette x:x0 y:y];
    }
    [bitmap drawCString:bottom palette:palette x:x0 y:y0+h-heightForBottom];
}
/*
FIXME this is the correct one. the one being used has one pixel cut off on the right side
+ (char *)cStringForAmigaVerticalScrollBarTop
{
    return
"oooooXXXXXXoooo\n"
"bbbbbbbbbbbbbbb\n"
"oooXXooXXooXXoo\n"
"bbbbbbbbbbbbbbb\n"
"oXXooooXXooooXX\n"
"bbbbbbbbbbbbbbb\n"
"oooooooXXoooooo\n"
"bbbbbbbbbbbbbbb\n"
"oooooooXXoooooo\n"
"bbbbbbbbbbbbbbb\n"
"oooooooXXoooooo\n"
"bbbbbbbbbbbbbbb\n"
"ooooooooooooooo\n"
"bbbbbbbbbbbbbbb\n"
"ooXXXXXXXXXXXXo\n"
"bbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaVerticalScrollBarMiddle
{
    return
"ooXXooooooooXXo\n"
"bbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaVerticalScrollBarBottom
{
    return
"ooXXXXXXXXXXXXo\n"
"bbbbbbbbbbbbbbb\n"
"ooooooooooooooo\n"
"bbbbbbbbbbbbbbb\n"
"oooooooXXoooooo\n"
"bbbbbbbbbbbbbbb\n"
"oooooooXXoooooo\n"
"bbbbbbbbbbbbbbb\n"
"oooooooXXoooooo\n"
"bbbbbbbbbbbbbbb\n"
"oXXooooXXooooXX\n"
"bbbbbbbbbbbbbbb\n"
"oooXXooXXooXXoo\n"
"bbbbbbbbbbbbbbb\n"
"oooooXXXXXXoooo\n"
"bbbbbbbbbbbbbbb\n"
;
}
*/
+ (char *)cStringForAmigaVerticalScrollBarTop
{
    return
"oooooXXXXXXooo\n"
"bbbbbbbbbbbbbb\n"
"oooXXooXXooXXo\n"
"bbbbbbbbbbbbbb\n"
"oXXooooXXooooX\n"
"bbbbbbbbbbbbbb\n"
"oooooooXXooooo\n"
"bbbbbbbbbbbbbb\n"
"oooooooXXooooo\n"
"bbbbbbbbbbbbbb\n"
"oooooooXXooooo\n"
"bbbbbbbbbbbbbb\n"
"oooooooooooooo\n"
"bbbbbbbbbbbbbb\n"
"ooXXXXXXXXXXXX\n"
"bbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaVerticalScrollBarMiddle
{
    return
"ooXXooooooooXX\n"
"bbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaVerticalScrollBarBottom
{
    return
"ooXXXXXXXXXXXX\n"
"bbbbbbbbbbbbbb\n"
"oooooooooooooo\n"
"bbbbbbbbbbbbbb\n"
"oooooooXXooooo\n"
"bbbbbbbbbbbbbb\n"
"oooooooXXooooo\n"
"bbbbbbbbbbbbbb\n"
"oooooooXXooooo\n"
"bbbbbbbbbbbbbb\n"
"oXXooooXXooooX\n"
"bbbbbbbbbbbbbb\n"
"oooXXooXXooXXo\n"
"bbbbbbbbbbbbbb\n"
"oooooXXXXXXooo\n"
"bbbbbbbbbbbbbb\n"
;
}
+ (void)drawAmigaVerticalScrollBarInBitmap:(id)bitmap x:(int)x0 y:(int)y0 h:(int)h
{
    char *palette = [Definitions cStringForAmigaPalette];

    char *top = [Definitions cStringForAmigaVerticalScrollBarTop];
    char *middle = [Definitions cStringForAmigaVerticalScrollBarMiddle];
    char *bottom = [Definitions cStringForAmigaVerticalScrollBarBottom];

    int heightForTop = [Definitions heightForCString:top];
    int heightForMiddle = [Definitions heightForCString:middle];
    int heightForBottom = [Definitions heightForCString:bottom];

    int widthForMiddle = [Definitions widthForCString:middle];

    [bitmap drawCString:top palette:palette x:x0 y:y0];
    for (int y=y0+heightForTop; y<y0+h-heightForBottom; y+=heightForMiddle) {
        [bitmap drawCString:middle palette:palette x:x0 y:y];
    }
    [bitmap drawCString:bottom palette:palette x:x0 y:y0+h-heightForBottom];
}

static id drawerPalette =
@"b #000000\n"
@". #000022\n"
@"* #ff8800\n"
@"X #0055aa\n"
@"o #ffffff\n"
;

static id drawerPixels =
@"              ...........................................................\n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"          ....oooooooooooooooooooooooooooooooooooooooooooooooooooooo...o.\n"
@"          bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"      ....oooooooooooooooooooooooooooooooooooooooooooooooooooooooo...oo..\n"
@"      bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ................................................................ooo.o.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo..oooo..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..ooo......................................................ooo..ooo.o.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo.o..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..ooo.o.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..ooo..ooooooooooooooooo...oooooooooo...ooooooooooooooooo..ooo..oo.o..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..ooo..oooooooooooooooo................oooooooooooooooooo..ooo..o.o.. \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo..  \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..o..   \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"   ..ooo......................................................ooo....    \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo...     \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"   ................................................................      \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
;

static id openDrawerPalette =
@"b #000000\n"
@". #000022\n"
@"* #ff8800\n"
@"X #0055aa\n"
@"o #ffffff\n"
;

static id openDrawerPixels =
@"              ...........................................................\n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"          ....oooooooooooooooooooooooooooooooooooooooooooooooooooooo...o.\n"
@"          bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"      ....oooooooooooooooooooooooooooooooooooooooooooooooooooooooo...oo..\n"
@"      bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ................................................................ooo.o.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo..oooo..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..ooo......................................................ooo..ooo.o.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..o...  .. . . . . . . . . . . . . . . . . . . . . . . ....ooo..oo.o..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"  .... . . ..  . . . . . . . . . . . . . . . . . . . . . ..o..ooo..ooo.o.\n"
@"  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..........................................................oo..ooo..oo.o..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..o.o.. \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..oo..  \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..o..   \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"..ooooooooooooooooooo...oooooooooo...ooooooooooooooooooo..oo..ooo....    \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"..oooooooooooooooooo................oooooooooooooooooooo..o..oooo...     \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo...........      \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo...              \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb              \n"
@"..........................................................               \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb               \n"
;

static id textFilePalette =
@"b #000000\n"
@". #000022\n"
@"X #0055AA\n"
@"o #FFFFFF\n"
;
static id textFileSelectedPalette =
@"b #000000\n"
@"o #000022\n"
@"X #0055AA\n"
@". #FFFFFF\n"
;
static id textFilePixels =
@"..............................          \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb          \n"
@"..oooooooooooooooooooooooo..oo..        \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb        \n"
@"..oooooooooooooooooooooooo..oooo..      \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"..oooooooooooooooooooooooo..oooooo..    \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"..ooo.........oooooooooooo..oooooooo..  \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"..oooooooooooooooooooooooo..............\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooo.........oooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooooooo....o..........oo.......ooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooo..o........o................ooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooo....................o.......ooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooooooooooooooooooooo..........ooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"........................................\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;

@implementation Definitions(hkukgfdfthfnvbchjgfjygikghjghfjgj)
+ (id)AmigaDir
{
    id obj = [@"AmigaDir" asInstance];
    return obj;
}
@end

@interface AmigaDir : IvarObject
{
    time_t _timestamp;
    id _array;
    id _buttonDown;
    int _buttonDownOffsetX;
    int _buttonDownOffsetY;
    id _buttonDownTimestamp;
    id _selected;
}
@end
@implementation AmigaDir
- (void)updateFromCurrentDirectory:(Int4)r
{
    id bitmap = [[[[@"Bitmap" asClass] alloc] initWithWidth:1 height:1] autorelease];
    [bitmap useTopazFont];
    id arr = [@"." contentsOfDirectory];
    arr = [arr asFileArray];
    int x = 20;
    int y = 5;
    for (int i=0; i<[arr count]; i++) {
        id elt = [arr nth:i];
        id palette = nil;
        id pixels = nil;
        id selectedPalette = nil;
        id selectedPixels = nil;
        id fileType = [elt valueForKey:@"fileType"];
        if ([fileType isEqual:@"file"]) {
            palette = textFilePalette;
            pixels = textFilePixels;
            selectedPalette = textFileSelectedPalette;
            selectedPixels = textFilePixels;
        } else if ([fileType isEqual:@"directory"]) {
            palette = drawerPalette;
            pixels = drawerPixels;
            selectedPalette = drawerPalette;
            selectedPixels = openDrawerPixels;
        }
        if (!palette || !pixels) {
            continue;
        }
        [elt setValue:palette forKey:@"palette"];
        [elt setValue:pixels forKey:@"pixels"];
        [elt setValue:selectedPalette forKey:@"selectedPalette"];
        [elt setValue:selectedPixels forKey:@"selectedPixels"];
        int w = [Definitions widthForCString:[pixels UTF8String]];
        int h = [Definitions heightForCString:[pixels UTF8String]];
        int textWidth = [Definitions bitmapWidthForText:[elt valueForKey:@"filePath"]];
        if (textWidth > w) {
            if (x + textWidth + 5 >= r.w) {
                x = 20;
                y += h + 30;
            }
            x += (textWidth - w) / 2;
            [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
            [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
            [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
            [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
            x += w + ((textWidth - w) / 2) + 20;
        } else {
            if (x + w + 5 >= r.w) {
                x = 20;
                y += h + 30;
            }
            [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
            [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
            [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
            [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
            x += w + 20;
        }
    }
    [self setValue:arr forKey:@"array"];
}

- (void)handleBackgroundUpdate:(id)event
{
    time_t timestamp = [@"." fileModificationTimestamp];
    if (timestamp != _timestamp) {
        _timestamp = 0;
    }
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    if (!_timestamp) {
        _timestamp = [@"." fileModificationTimestamp];
        [self updateFromCurrentDirectory:r];
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap useTopazFont];
    [bitmap setColor:@"#0055aa"];
    [bitmap fillRect:r];
    [bitmap setColor:@"white"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if (_selected == elt) {
            id palette = [elt valueForKey:@"selectedPalette"];
            id pixels = [elt valueForKey:@"selectedPixels"];
            if (palette && pixels) {
                [bitmap drawCString:[pixels UTF8String] palette:[palette UTF8String] x:r.x+x y:r.y+y];
            }
        } else {
            id palette = [elt valueForKey:@"palette"];
            id pixels = [elt valueForKey:@"pixels"];
            if (palette && pixels) {
                [bitmap drawCString:[pixels UTF8String] palette:[palette UTF8String] x:r.x+x y:r.y+y];
            }
        }
        id filePath = [elt valueForKey:@"filePath"];
        [bitmap drawBitmapText:filePath centeredAtX:x+w/2 y:y+h-8];
    }
    [Definitions drawAmigaFuelGaugeInBitmap:bitmap x:r.x y:r.y h:r.h-16];
    [Definitions drawAmigaVerticalScrollBarInBitmap:bitmap x:r.x+r.w-14 y:r.y h:r.h-16];
    [Definitions drawAmigaHorizontalScrollBarInBitmap:bitmap x:r.x y:r.y+r.h-16 w:r.w-14];
}

- (void)handleMouseDown:(id)event
{
    [self setValue:nil forKey:@"selected"];
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if ((mouseX >= x) && (mouseX < x+w) && (mouseY >= y) && (mouseY < y+h)) {
            [self setValue:elt forKey:@"buttonDown"];
            [self setValue:elt forKey:@"selected"];
            _buttonDownOffsetX = mouseX - x;
            _buttonDownOffsetY = mouseY - y;
            struct timeval tv;
            gettimeofday(&tv, NULL);
            id timestamp = nsfmt(@"%ld.%06ld", tv.tv_sec, tv.tv_usec);
            if ([timestamp doubleValue] - [_buttonDownTimestamp doubleValue] <= 0.3) {
                id filePath = [_selected valueForKey:@"filePath"];
                if ([filePath length]) {
                    if ([filePath isDirectory]) {
                        id cmd = nsarr();
                        [cmd addObject:@"hotdog"];
                        [cmd addObject:@"amigadir"];
                        [cmd addObject:filePath];
                        [cmd runCommandInBackground];
                    }
                }
                [self setValue:nil forKey:@"buttonDownTimestamp"];
            } else {
                [self setValue:timestamp forKey:@"buttonDownTimestamp"];
            }
            break;
        }
    }
}

- (void)handleMouseMoved:(id)event
{
    if (_buttonDown) {
        int mouseX = [event intValueForKey:@"mouseX"];
        int mouseY = [event intValueForKey:@"mouseY"];
        [_buttonDown setValue:nsfmt(@"%d", mouseX - _buttonDownOffsetX) forKey:@"x"];
        [_buttonDown setValue:nsfmt(@"%d", mouseY - _buttonDownOffsetY) forKey:@"y"];
        [self setValue:nil forKey:@"buttonDownTimestamp"];
    }
}

- (void)handleMouseUp:(id)event
{
    [self setValue:nil forKey:@"buttonDown"];
}

@end

