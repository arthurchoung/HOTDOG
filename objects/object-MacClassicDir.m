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

static id leftArrowPixels =
@"bbbbbbbbbbbbbbb\n"
@"......b.......b\n"
@".....bb.......b\n"
@"....b.b.......b\n"
@"...b..bbbbb...b\n"
@"..b.......b...b\n"
@".b........b...b\n"
@"b.........b...b\n"
@".b........b...b\n"
@"..b.......b...b\n"
@"...b..bbbbb...b\n"
@"....b.b.......b\n"
@".....bb.......b\n"
@"......b.......b\n"
@"..............b\n"
;
static id bottomScrollBarPixels =
@"b\n"
@".\n"
@".\n"
@".\n"
@".\n"
@".\n"
@".\n"
@".\n"
@".\n"
@".\n"
@".\n"
@".\n"
@".\n"
@".\n"
@".\n"
;
static id rightArrowPixels =
@"bbbbbbbbbbbbbbb\n"
@"b.......b......\n"
@"b.......bb.....\n"
@"b.......b.b....\n"
@"b...bbbbb..b...\n"
@"b...b.......b..\n"
@"b...b........b.\n"
@"b...b.........b\n"
@"b...b........b.\n"
@"b...b.......b..\n"
@"b...bbbbb..b...\n"
@"b.......b.b....\n"
@"b.......bb.....\n"
@"b.......b......\n"
@"b..............\n"
;
static id upArrowPixels =
@"b..............\n"
@"b......b.......\n"
@"b.....b.b......\n"
@"b....b...b.....\n"
@"b...b.....b....\n"
@"b..b.......b...\n"
@"b.b.........b..\n"
@"bbbbb.....bbbb.\n"
@"b...b.....b....\n"
@"b...b.....b....\n"
@"b...b.....b....\n"
@"b...bbbbbbb....\n"
@"b..............\n"
@"b..............\n"
@"bbbbbbbbbbbbbbb\n"
;

static id rightScrollBarPixels =
@"b..............\n"
;

static id downArrowPixels =
@"bbbbbbbbbbbbbbb\n"
@"b..............\n"
@"b..............\n"
@"b...bbbbbbb....\n"
@"b...b.....b....\n"
@"b...b.....b....\n"
@"b...b.....b....\n"
@"bbbbb.....bbbb.\n"
@"b.b.........b..\n"
@"b..b.......b...\n"
@"b...b.....b....\n"
@"b....b...b.....\n"
@"b.....b.b......\n"
@"b......b.......\n"
@"b..............\n"
;

static id folderPalette =
@"b #000000\n"
@". #ffffff\n"
;
static id selectedFolderPalette = 
@". #000000\n"
@"b #ffffff\n"
;
static id folderPixels =
@"     bbbbbbb                   \n"
@"    b.......b                  \n"
@"   b.........b                 \n"
@"  b...........b                \n"
@" bbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"b.............................b\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;

static id documentPalette =
@"b #000000\n"
@". #ffffff\n"
;
static id selectedDocumentPalette =
@". #000000\n"
@"b #ffffff\n"
;
static id documentPixels =
@"bbbbbbbbbbbbbbbbbbb      \n"
@"b.................bb     \n"
@"b.................b.b    \n"
@"b.................b..b   \n"
@"b.................b...b  \n"
@"b.................b....b \n"
@"b.................bbbbbbb\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"b.......................b\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbb\n"
;

@implementation Definitions(hkukgfdfthfnvbchjgfjygikghjghfjgfjdksfjksdkjfj)
+ (id)MacClassicDir
{
    id obj = [@"MacClassicDir" asInstance];
    return obj;
}
@end

@interface MacClassicDir : IvarObject
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
@implementation MacClassicDir
- (int)preferredWidth
{
    return 600;
}
- (int)preferredHeight
{
    return 360;
}
- (void)updateFromCurrentDirectory:(Int4)r
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    [bitmap useMonacoFont];
    id arr = [@"." contentsOfDirectory];
    arr = [arr asFileArray];
    int x = 40;
    int y = 5;
    for (int i=0; i<[arr count]; i++) {
        id elt = [arr nth:i];
        id palette = nil;
        id pixels = nil;
        id selectedPalette = nil;
        id selectedPixels = nil;
        id fileType = [elt valueForKey:@"fileType"];
        if ([fileType isEqual:@"file"]) {
            palette = documentPalette;
            pixels = documentPixels;
            selectedPalette = selectedDocumentPalette;
            selectedPixels = documentPixels;
        } else if ([fileType isEqual:@"directory"]) {
            palette = folderPalette;
            pixels = folderPixels;
            selectedPalette = selectedFolderPalette;
            selectedPixels = folderPixels;
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
        if (x + w + 5 >= r.w) {
            x = 40;
            y += h + 30;
        }
        [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
        [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
        [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
        [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
        x += w + 50 + 20;
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
    [bitmap useMonacoFont];
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
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
        [bitmap drawBitmapText:filePath centeredAtX:x+w/2 y:y+h-2];
    }
/*
    int infoBarHeight = 30;
    if (infoBarHeight) {
        [bitmap setColor:@"black"];
        [bitmap drawLineAtX:r.x y:r.y+22 x:r.x+r.w-1 y:r.y+22];
        [bitmap drawLineAtX:r.x y:r.y+20 x:r.x+r.w-1 y:r.y+20];
        [bitmap useGenevaFont];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:@"16 items        3,622K in disk           6,453K available" x:20 y:r.y+5];
    }
*/
    {
        char *left = [leftArrowPixels UTF8String];
        char *middle = [bottomScrollBarPixels UTF8String];
        char *right = [rightArrowPixels UTF8String];
        char *palette = [folderPalette UTF8String];
        [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:r.x y:r.y+r.h-15 w:r.w-15 palette:palette];
    }
    {
        char *top = [upArrowPixels UTF8String];
        char *middle = [rightScrollBarPixels UTF8String];
        char *bottom = [downArrowPixels UTF8String];
        char *palette = [folderPalette UTF8String];
        [Definitions drawInBitmap:bitmap top:top palette:palette middle:middle palette:palette bottom:bottom palette:palette x:r.x+r.w-15 y:r.y h:r.h-15];
    }
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
            if (_buttonDownTimestamp && ([timestamp doubleValue] - [_buttonDownTimestamp doubleValue] <= 0.3)) {
                id filePath = [_selected valueForKey:@"filePath"];
                if ([filePath length]) {
                    if ([filePath isDirectory]) {
                        id cmd = nsarr();
                        [cmd addObject:@"hotdog"];
                        [cmd addObject:@"macclassicdir"];
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

