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

static id drawerPalette =
@"b #000000\n"
@". #000022\n"
@"* #ff8800\n"
@"X #0055aa\n"
@"o #ffffff\n"
;

static id drawerPixels =
@"           ...........................................................\n"
@"           bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"       ....oooooooooooooooooooooooooooooooooooooooooooooooooooooo...o.\n"
@"       bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ....oooooooooooooooooooooooooooooooooooooooooooooooooooooooo...oo..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"................................................................ooo.o.\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo..oooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooo......................................................ooo..ooo.o.\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo.o..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..ooo.o.\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooo..ooooooooooooooooo...oooooooooo...ooooooooooooooooo..ooo..oo.o..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooo..oooooooooooooooo................oooooooooooooooooo..ooo..o.o.. \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo..  \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..o..   \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"..ooo......................................................ooo....    \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo...     \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"................................................................      \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
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
    time_t _currentDirectoryTimestamp;
    id _array;
    id _buttonDown;
    int _buttonDownOffsetX;
    int _buttonDownOffsetY;
}
@end
@implementation AmigaDir
- (void)updateFromCurrentDirectory:(Int4)r
{
    id arr = [@"." contentsOfDirectory];
    arr = [arr asFileArray];
    int x = 20;
    int y = 5;
    for (int i=0; i<[arr count]; i++) {
        id elt = [arr nth:i];
        id palette = nil;
        id pixels = nil;
        id fileType = [elt valueForKey:@"fileType"];
        if ([fileType isEqual:@"file"]) {
            palette = textFilePalette;
            pixels = textFilePixels;
        } else if ([fileType isEqual:@"directory"]) {
            palette = drawerPalette;
            pixels = drawerPixels;
        }
        if (!palette || !pixels) {
            continue;
        }
        [elt setValue:palette forKey:@"palette"];
        [elt setValue:pixels forKey:@"pixels"];
        int w = [Definitions widthForCString:[pixels UTF8String]];
        int h = [Definitions heightForCString:[pixels UTF8String]];
        [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
        [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
        [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
        [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
        x += w + 20;
        if (x+w+20 >= r.w) {
            x = 20;
            y += h + 30;
        }
    }
    [self setValue:arr forKey:@"array"];
}

- (void)handleBackgroundUpdate:(id)event
{
    time_t timestamp = [@"." fileModificationTimestamp];
    if (timestamp != _currentDirectoryTimestamp) {
        _currentDirectoryTimestamp = 0;
    }
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    if (!_currentDirectoryTimestamp) {
        _currentDirectoryTimestamp = [@"." fileModificationTimestamp];
        [self updateFromCurrentDirectory:r];
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap useTopazFont];
    [bitmap setColor:@"blue"];
    [bitmap fillRect:r];
    [bitmap setColor:@"white"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        id palette = [elt valueForKey:@"palette"];
        id pixels = [elt valueForKey:@"pixels"];
        if (palette && pixels) {
            [bitmap drawCString:[pixels UTF8String] palette:[palette UTF8String] x:r.x+x y:r.y+y];
        }
        id filePath = [elt valueForKey:@"filePath"];
        [bitmap drawBitmapText:filePath centeredAtX:x+w/2 y:y+h-2];
    }
}

- (void)handleMouseDown:(id)event
{
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
            _buttonDownOffsetX = mouseX - x;
            _buttonDownOffsetY = mouseY - y;
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
    }
}

- (void)handleMouseUp:(id)event
{
    [self setValue:nil forKey:@"buttonDown"];
}

@end

