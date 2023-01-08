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

static char *diskPalette =
"b #000000\n"
". #ffffff\n"
;
static char *selectedDiskPalette =
". #000000\n"
"b #ffffff\n"
;
static char *diskPixels =
"                                        bbbbbbbbbbbbbb          \n"
"                                        bbbbbbbbbbbbbb          \n"
"                                      bbbb..........bbbb        \n"
"                                      bbbb..........bbbb        \n"
"                  bbbbbbbbbbbbbb  bbbbbb..............bbbbbb    \n"
"                  bbbbbbbbbbbbbb  bbbbbb..............bbbbbb    \n"
"                bbbb..........bbbb........................bb    \n"
"                bbbb..........bbbb........................bb    \n"
"            bbbbbb..............bbbbbbbbbbbbbbbbbbbbbbbb..bbbbbb\n"
"            bbbbbb..............bbbbbbbbbbbbbbbbbbbbbbbb..bbbbbb\n"
"            bb........................................bb..bb..bb\n"
"            bb........................................bb..bb..bb\n"
"        bbbbbbbbbbbbbbbbbb..bbbbbbbbbbbbbb..bbbbbbbb..bb....bbbb\n"
"        bbbbbbbbbbbbbbbbbb..bbbbbbbbbbbbbb..bbbbbbbb..bb....bbbb\n"
"        bb................bbbb..........bbbb......bb..bb..bbbbbb\n"
"        bb................bbbb..........bbbb......bb..bb..bbbbbb\n"
"    bbbbbbbbbbbbbbbbbbbbbbbb..............bbbbbb..bb....bbbb..bb\n"
"    bbbbbbbbbbbbbbbbbbbbbbbb..............bbbbbb..bb....bbbb..bb\n"
"    bb........................................bb..bb..bbbb....bb\n"
"    bb........................................bb..bb..bbbb....bb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb......bbbb......bb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb......bbbb......bb\n"
"bb..........................................bb....bbbb......bbbb\n"
"bb..........................................bb....bbbb......bbbb\n"
"bb..........bbbbbb..........................bb..bbbb......bb..bb\n"
"bb..........bbbbbb..........................bb..bbbb......bb..bb\n"
"bb........bb......bb........................bbbbbb......bb....bb\n"
"bb........bb......bb........................bbbbbb......bb....bb\n"
"bb........bbbbbbbbbb........................bbbb......bb....bbbb\n"
"bb........bbbbbbbbbb........................bbbb......bb....bbbb\n"
"bb........bb......bb........................bb......bb....bb..bb\n"
"bb........bb......bb........................bb......bb....bb..bb\n"
"bb........bb......bb........................bb....bb....bb....bb\n"
"bb........bb......bb........................bb....bb....bb....bb\n"
"bb..........................................bb..bb....bb......bb\n"
"bb..........................................bb..bb....bb......bb\n"
"bb............bbbbbbbbbbbbbbbb..............bbbb....bb......bbbb\n"
"bb............bbbbbbbbbbbbbbbb..............bbbb....bb......bbbb\n"
"bb............bb............bb..............bb....bb......bbbb..\n"
"bb............bb............bb..............bb....bb......bbbb..\n"
"bb............bb............bb..............bb..bb......bbbb..  \n"
"bb............bb............bb..............bb..bb......bbbb..  \n"
"bb............bbbbbbbbbbbbbbbb..............bbbb......bbbb..    \n"
"bb............bbbbbbbbbbbbbbbb..............bbbb......bbbb..    \n"
"bb..........................................bb......bbbb..      \n"
"bb..........................................bb......bbbb..      \n"
"bb..........................................bb....bbbb..        \n"
"bb..........................................bb....bbbb..        \n"
"bb..........bbbb..........bbbb..............bb..bbbb..          \n"
"bb..........bbbb..........bbbb..............bb..bbbb..          \n"
"bb........bbbbbbbbbbbbbbbbbb................bbbbbb..            \n"
"bb........bbbbbbbbbbbbbbbbbb................bbbbbb..            \n"
"bb..........................................bbbb..              \n"
"bb..........................................bbbb..              \n"
"bb..........................................bb..                \n"
"bb..........................................bb..                \n"
"bb..........................................bb                  \n"
"bb..........................................bb                  \n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb                  \n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb                  \n"
;


@interface AtariSTDisk : IvarObject
{
    id _path;
    id _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;
}
@end
@implementation AtariSTDisk
- (int)preferredWidth
{
    static int w = 0;
    if (!w) {
        w = [Definitions widthForCString:diskPixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useAtariSTFont];
            int textWidth = [bitmap bitmapWidthForText:_path];
            if (textWidth < 8*16) {
                textWidth = 8*16;
            }
            if (textWidth > w) {
                w = textWidth;
            }
        }
    }
    return w;
}
- (int)preferredHeight
{
    static int h = 0;
    if (!h) {
        h = [Definitions heightForCString:diskPixels];
        h += 16;
    }
    return h;
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    BOOL hasFocus = NO;
    {
        id windowManager = [@"windowManager" valueForKey];
        unsigned long focusInEventWindow = [[windowManager valueForKey:@"focusInEventWindow"] unsignedLongValue];
        unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
        if (focusInEventWindow && (focusInEventWindow == win)) {
            hasFocus = YES;
        }
    }

    int w = [Definitions widthForCString:diskPixels];
    int h = [Definitions heightForCString:diskPixels];

    if (hasFocus) {
        [bitmap drawCString:diskPixels palette:selectedDiskPalette x:r.x+(r.w-w)/2 y:r.y];
    } else {
        [bitmap drawCString:diskPixels palette:diskPalette x:r.x+(r.w-w)/2 y:r.y];
    }
    if (hasFocus) {
        [bitmap setColor:@"black"];
    } else {
        [bitmap setColor:@"white"];
    }
    [bitmap fillRectangleAtX:r.x y:r.y+h w:r.w h:r.h-h];
    if ([_path length]) {
        if (hasFocus) {
            [bitmap setColor:@"white"];
        } else {
            [bitmap setColor:@"black"];
        }
        [bitmap useAtariSTFont];
        int textWidth = [bitmap bitmapWidthForText:_path];
        [bitmap drawBitmapText:_path x:r.x+(r.w-textWidth)/2 y:r.y+h];
    }

    id windowManager = [@"windowManager" valueForKey];
    unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
    if (win) {
        [windowManager addMaskToWindow:win bitmap:bitmap];
    }
}

- (void)handleMouseDown:(id)event
{
    {
        id x11dict = [event valueForKey:@"x11dict"];
        unsigned long win = [[x11dict valueForKey:@"window"] unsignedLongValue];
        id windowManager = [@"windowManager" valueForKey];
        [windowManager XRaiseWindow:win];
    }

    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    _buttonDown = YES;
    _buttonDownX = mouseX;
    _buttonDownY = mouseY;

    struct timeval tv;
    gettimeofday(&tv, NULL);
    id timestamp = nsfmt(@"%ld.%06ld", tv.tv_sec, tv.tv_usec);
    if (_buttonDownTimestamp) {
        if ([timestamp doubleValue]-[_buttonDownTimestamp doubleValue] <= 0.3) {
            [self setValue:nil forKey:@"buttonDownTimestamp"];
            [self handleDoubleClick];
            return;
        }
    }
    [self setValue:timestamp forKey:@"buttonDownTimestamp"];
}

- (void)handleMouseMoved:(id)event
{
    if (!_buttonDown) {
        return;
    }
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    id dict = [event valueForKey:@"x11dict"];

    int newX = mouseRootX - _buttonDownX;
    int newY = mouseRootY - _buttonDownY;

    [dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
    [dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

    [dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
}
- (void)handleMouseUp:(id)event
{
    _buttonDown = NO;
}
- (void)handleRightMouseDown:(id)event
{
    id windowManager = [event valueForKey:@"windowManager"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    id obj = nil;//[[menuCSV parseCSVFromString] asMenu];
    if (obj) {
        [obj setValue:self forKey:@"contextualObject"];
        [windowManager openButtonDownMenuForObject:obj x:mouseRootX y:mouseRootY w:0 h:0];
    }
}
- (void)handleDoubleClick
{
    [self handleOpen];
}
- (void)handleOpen
{
    if ([_path length]) {
        id cmd = nsarr();
        [cmd addObject:@"hotdog"];
        [cmd addObject:@"ataristdir"];
        [cmd addObject:_path];
        [cmd runCommandInBackground];
    }
}
@end

