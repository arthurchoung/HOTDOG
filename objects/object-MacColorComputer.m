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

static char *computerPalette =
"b #000000\n"
". #222222\n"
"X #444444\n"
"o #555555\n"
"+ #777777\n"
"@ #DD0000\n"
"# #00BB00\n"
"$ #888888\n"
"& #cccccc\n"
"* #ccccff\n"
"= #ffffff\n"
;
static char *selectedComputerPalette =
"b #000000\n"
". #111111\n"
"X #222222\n"
"o #2a2a2a\n"
"+ #3b3b3b\n"
"@ #6e0000\n"
"# #005d00\n"
"$ #444444\n"
"& #666666\n"
"* #33337f\n"
"= #7f7f7f\n"
;
static char *computerPixels =
" bbbbbbbbbbbbbbbbbbbbbb \n"
"b&&&&&&&&&&&&&&&&&&&&&&b\n"
"b&&&&&&&&&&&&&&&&&&&&&&b\n"
"b&&&XXXXXXXXXXXXXXXX&&&b\n"
"b&&X****************=&&b\n"
"b&&X****************=&&b\n"
"b&&X****************=&&b\n"
"b&&X****************=&&b\n"
"b&&X****************=&&b\n"
"b&&X****************=&&b\n"
"b&&X****************=&&b\n"
"b&&X****************=&&b\n"
"b&&X****************=&&b\n"
"b&&X****************=&&b\n"
"b&&X****************=&&b\n"
"b&&X****************=&&b\n"
"b&&&================&&&b\n"
"b&&&&&&&&&&&&&&&&&&&&&&b\n"
"b&&&&&&&&&&&&&&&&&&&&&&b\n"
"b&&&&&&&&&&&&&&&&&&&&&&b\n"
"b&&&&&&&&&&&&&&&&&&&&&&b\n"
"b&&&&&&&&&&&bbbbbbbb&&&b\n"
"b&&&&&&&&&&&========&&&b\n"
"b&&##&&&&&&&&&&&&&&&&&&b\n"
"b&&@@&&&&&&&&&&&&&&&&&&b\n"
"b&&&&&&&&&&&&&&&&&&&&&&b\n"
" bbbbbbbbbbbbbbbbbbbbbb \n"
" booooooXXXXX.........b \n"
" b++++++++ooXXXX......b \n"
" b$$$$$$$$+++ooXXXX...b \n"
" bbbbbbbbbbbbbbbbbbbbbb \n"
;

@interface MacColorComputer : IvarObject
{
    id _path;
    id _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;
}
@end
@implementation MacColorComputer
- (int)preferredWidth
{
    static int w = 0;
    if (!w) {
        w = [Definitions widthForCString:computerPixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useMonacoFont];
            int textWidth = [bitmap bitmapWidthForText:_path];
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
        h = [Definitions heightForCString:computerPixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useMonacoFont];
            int textHeight = [bitmap bitmapHeightForText:_path];
            h += textHeight;
        }
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

    int w = [Definitions widthForCString:computerPixels];
    int h = [Definitions heightForCString:computerPixels];

    if (hasFocus) {
        [bitmap drawCString:computerPixels palette:selectedComputerPalette x:r.x+(r.w-w)/2 y:r.y];
    } else {
        [bitmap drawCString:computerPixels palette:computerPalette x:r.x+(r.w-w)/2 y:r.y];
    }
    if ([_path length]) {
        [bitmap useMonacoFont];
        int textWidth = [bitmap bitmapWidthForText:_path];
        int textHeight = [bitmap bitmapHeightForText:_path];
        if (hasFocus) {
            [bitmap setColor:@"black"];
        } else {
            [bitmap setColor:@"white"];
        }
        [bitmap fillRectangleAtX:r.x+(r.w-textWidth)/2 y:r.y+h w:textWidth h:textHeight];
        if (hasFocus) {
            [bitmap setColor:@"white"];
        } else {
            [bitmap setColor:@"black"];
        }
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
        [cmd addObject:@"maccolordir"];
        [cmd addObject:_path];
        [cmd runCommandInBackground];
    }
}
@end

