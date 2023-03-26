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

static char *iconPalette =
"b #000000\n"
"X #ffff00\n"
"o #0000AA\n"
"O #0000ff\n"
"+ #00ffff\n"
"@ #868A8E\n"
"# #C3C7CB\n"
"$ #ffffff\n"
;
static char *iconPixels =
"           bbbbbbbbbbbbbbbb     \n"
"          b##############$@b    \n"
"         b$$$$$$$$$$$$$$$@@b    \n"
"        b################@@b    \n"
"        b##@@@@@@@@@@@@##@@b    \n"
"        b#@bbbbbbbbbbbb$#@@b    \n"
"        b#@bOOOOOOOOOOb$#@@b    \n"
"        b#@bO+OOOOOOOOb$#@@b    \n"
"        b#@bO+OOOOOOOOb$#@@b    \n"
"        b#@bOOOOOOOOOOb$#@@b    \n"
"    bb  b#@bOOOOOOOOOOb$#@@b    \n"
"   b#b  bbbbbOOOOOOOOOb$#@@b    \n"
"  b##b b$$$$$boOOOOOOOb$#@@b    \n"
" b##@#bb$$$$$bbbbbbbbbb$#@@b    \n"
"b##@###b@@@@@b##$$$$$$$##@@bbbb \n"
"b#@###b@####bb@@#########@b@@#@b\n"
"b@#bbbbb###bobbbbbbbbbbbbb@@#@@b\n"
" bb$$$$$b#boob@@############@@@b\n"
"  b$$$$$bbooob##$$$$$$$$$$$@@@@b\n"
"  bbbbbbboooob@@###########@@@@b\n"
"  bOOOOOoooo#b@@bbbbbbbbbb#@@@@b\n"
"  bOOOOOooo##b@@#bbb$bbbb@#@@@b \n"
"  bOOOOOoo###b@@bbbbbbbb@@@@@b  \n"
"  bOOOOOo####b@bX$X$X$X@@@@@b   \n"
"  b$$$$$@####bbbbbbbbbbbbbbb    \n"
"  b$$$$$@####b                  \n"
"  b$$$$$@####b                  \n"
"  b$$$$$@###b       bbbbbbbbbb  \n"
"  b$$$$$@##b       b$X$X$X$Xb   \n"
"  b$$$$$@#b       bbbbbbbbbb    \n"
"  b$$$$$@b       bbbbb$bbbb     \n"
"  bbbbbbb       bbbbbbbbbb      \n"
;

@interface HotDogStandWindowsSetupIcon : IvarObject
{
    id _path;
    id _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;

    id _dragX11Dict;
}
@end
@implementation HotDogStandWindowsSetupIcon
- (int)preferredWidth
{
    static int w = 0;
    if (!w) {
        w = [Definitions widthForCString:iconPixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useWinSystemFont];
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
        h = [Definitions heightForCString:iconPixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useWinSystemFont];
            int textHeight = [bitmap bitmapHeightForText:_path];
            h += textHeight;
        }
    }
    return h;
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    int isSelected = [context intValueForKey:@"isSelected"];

    BOOL hasFocus = NO;
    {
        id windowManager = [@"windowManager" valueForKey];
        unsigned long focusInEventWindow = [[windowManager valueForKey:@"focusInEventWindow"] unsignedLongValue];
        unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
        if (focusInEventWindow && (focusInEventWindow == win)) {
            hasFocus = YES;
        }
    }

    int w = [Definitions widthForCString:iconPixels];
    int h = [Definitions heightForCString:iconPixels];

    [bitmap drawCString:iconPixels palette:iconPalette x:r.x+(r.w-w)/2 y:r.y];

    if ([_path length]) {
        [bitmap useWinSystemFont];
        int textWidth = [bitmap bitmapWidthForText:_path];
        int textHeight = [bitmap bitmapHeightForText:_path];
        if (hasFocus || isSelected) {
            id color = [Definitions valueForEnvironmentVariable:@"HOTDOG_HASFOCUSTITLEBARCOLOR"];
            if (color) {
                [bitmap setColor:color];
            } else {
                [bitmap setColor:@"black"];
            }
            [bitmap fillRectangleAtX:r.x+(r.w-textWidth)/2 y:r.y+h w:textWidth h:textHeight];
            [bitmap setColor:@"white"];
            [bitmap drawBitmapText:_path x:r.x+(r.w-textWidth)/2 y:r.y+h];
        } else {
            id color = [Definitions valueForEnvironmentVariable:@"HOTDOG_WINDOWTEXTCOLOR"];
            if (color) {
                [bitmap setColor:color];
            } else {
                [bitmap setColor:@"white"];
            }
            [bitmap drawBitmapText:_path x:r.x+(r.w-textWidth)/2 y:r.y+h];
        }
    }

    id windowManager = [@"windowManager" valueForKey];
    unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
    if (win) {
        [windowManager addMaskToWindow:win bitmap:bitmap];
    }
}

- (void)handleMouseDown:(id)event
{
    id windowManager = [@"windowManager" valueForKey];
    id x11dict = [event valueForKey:@"x11dict"];

    {
        unsigned long win = [[x11dict valueForKey:@"window"] unsignedLongValue];
        if (win) {
            [windowManager XRaiseWindow:win];
        }
    }

    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    _buttonDown = YES;
    _buttonDownX = mouseX;
    _buttonDownY = mouseY;

    id timestamp = [Definitions gettimeofday];
    if (_buttonDownTimestamp) {
        if ([timestamp doubleValue]-[_buttonDownTimestamp doubleValue] <= 0.3) {
            [self setValue:nil forKey:@"buttonDownTimestamp"];
            if ([self respondsToSelector:@selector(handleDoubleClick)]) {
                [self handleDoubleClick];
            }
            return;
        }
    }
    [self setValue:timestamp forKey:@"buttonDownTimestamp"];
}

- (void)handleMouseMoved:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];

    if (!_buttonDown && !_dragX11Dict) {
        return;
    }

    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    if (!_dragX11Dict) {
        id windowManager = [event valueForKey:@"windowManager"];
        id objectWindows = [windowManager valueForKey:@"objectWindows"];
        for (int i=0; i<[objectWindows count]; i++) {
            id elt = [objectWindows nth:i];
            [elt setValue:nil forKey:@"isSelected"];
        }
        [x11dict setValue:@"1" forKey:@"isSelected"];

        id newx11dict = [Definitions selectedBitmapForSelectedItemsInArray:objectWindows buttonDownElt:x11dict offsetX:_buttonDownX y:_buttonDownY mouseRootX:mouseRootX y:mouseRootY windowManager:windowManager];

        [self setValue:newx11dict forKey:@"dragX11Dict"];
    } else {

        int newX = mouseRootX - [_dragX11Dict intValueForKey:@"buttonDownOffsetX"];
        int newY = mouseRootY - [_dragX11Dict intValueForKey:@"buttonDownOffsetY"];

        [_dragX11Dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
        [_dragX11Dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

        [_dragX11Dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
    }
}
- (void)handleMouseUp:(id)event
{
    _buttonDown = NO;
    id x11dict = [event valueForKey:@"x11dict"];
    if (_dragX11Dict) {

        id windowManager = [event valueForKey:@"windowManager"];
        unsigned long window = [_dragX11Dict unsignedLongValueForKey:@"window"];
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];

        BOOL success = NO;

        unsigned long underneathWindow = [windowManager topMostWindowUnderneathWindow:window x:mouseRootX y:mouseRootY];
        if (underneathWindow) {
            id underneathx11dict = [windowManager dictForObjectWindow:underneathWindow];
            if (underneathx11dict == x11dict) {
            } else {
                id object = [underneathx11dict valueForKey:@"object"];
                if ([object respondsToSelector:@selector(handleDragAndDrop:)]) {
                    [object handleDragAndDrop:x11dict];
                    success = YES;
                }
            }
        }
        if (!success) {
            int newX = mouseRootX - _buttonDownX;
            int newY = mouseRootY - _buttonDownY;
            [x11dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
            [x11dict setValue:nsfmt(@"%d", newY) forKey:@"y"];
            [x11dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
        }

        [_dragX11Dict setValue:@"1" forKey:@"shouldCloseWindow"];
        [self setValue:nil forKey:@"dragX11Dict"];
    }
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
@end

