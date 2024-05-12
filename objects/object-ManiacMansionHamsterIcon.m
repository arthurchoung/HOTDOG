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

static id menuCSV = 
@"displayName,messageForClick\n"
@"Hamster,\n"
;

static char *hamsterPalette =
"b #000000\n"
"X #AC0000\n"
"o #AC5400\n"
"O #FF5452\n"
"+ #0000AC\n"
"@ #5254FF\n"
"# #ACA9AC\n"
"$ #FFFEFF\n"
;

static char *hamsterPixels =
"........................................................\n"
"........................................................\n"
"........................................................\n"
"........................................................\n"
"........................................................\n"
"........................................................\n"
"........................................................\n"
"........................................................\n"
"........................................................\n"
"........................................................\n"
"........................................................\n"
"........................................................\n"
"........................................................\n"
"........................................................\n"
"............$$....$$..........oooooooo..................\n"
"............$$....$$..........oooooooo..................\n"
"..........$$$$$$$$$$$$bb..$$$$oooooooooooo..............\n"
"..........$$$$$$$$$$$$bb..$$$$oooooooooooo..............\n"
"........$$$$$$XXOO$$$$bbbb$$$$$$$$oooooooooo............\n"
"........$$$$$$XXOO$$$$bbbb$$$$$$$$oooooooooo............\n"
"......$$$$$$$$####$$$$$$$$$$$$$$$$$$$$$$$$$$$$..........\n"
"......$$$$$$$$####$$$$$$$$$$$$$$$$$$$$$$$$$$$$..........\n"
"......OO$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$........\n"
"......OO$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$........\n"
"..........##$$$$$$$$$$$$$$$$$$$$$$$$####$$$$$$$$........\n"
"..........##$$$$$$$$$$$$$$$$$$$$$$$$####$$$$$$$$........\n"
"..........$$$$$$$$$$######$$$$$$$$##$$$$$$$$$$$$........\n"
"..........$$$$$$$$$$######$$$$$$$$##$$$$$$$$$$$$........\n"
"........OO##..XXOO####$$$$$$$$$$####$$$$$$$$##..........\n"
"........OO##..XXOO####$$$$$$$$$$####$$$$$$$$##..........\n"
;

static char *cookedHamsterPalette =
"X #AC0000\n"
"o #AC5400\n"
"O #FF5452\n"
"+ #0000AC\n"
"@ #5254FF\n"
"# #ACA9AC\n"
"$ #FFFEFF\n"
;

static char *cookedHamsterPixels =
"..............XX..........................XX............\n"
"..............XX..........................XX............\n"
"....OOOO........XX..XXXXXXXX............XX....OO........\n"
"....OOOO........XX..XXXXXXXX............XX....OO........\n"
"..XXXXXXXXOO......XXOOXXXXXXXXXX....XXXXXXXXXX..........\n"
"..XXXXXXXXOO......XXOOXXXXXXXXXX....XXXXXXXXXX..........\n"
"OOXX....XXXXXX......XXXXXXXX............XXXX........OO..\n"
"OOXX....XXXXXX......XXXXXXXX............XXXX........OO..\n"
"XXXX......XXXXXX......OOXXXXXXXX....XXXXXXXX......XX....\n"
"XXXX......XXXXXX......OOXXXXXXXX....XXXXXXXX......XX....\n"
"OO..........XXXXXXXXXXXXXXXXXXXXXXXXXXXX................\n"
"OO..........XXXXXXXXXXXXXXXXXXXXXXXXXXXX................\n"
"........XX........OOXXXXXXOOXXXXXXXXXXXX..XX............\n"
"........XX........OOXXXXXXOOXXXXXXXXXXXX..XX............\n"
"..XXOO......XX..OOXXXXOOXXXXXXXXXXXXXX......XX..OO......\n"
"..XXOO......XX..OOXXXXOOXXXXXXXXXXXXXX......XX..OO......\n"
"......XX............XXXX....XXXXXXXXXXXXXX..............\n"
"......XX............XXXX....XXXXXXXXXXXXXX..............\n"
"....OOXX......OOXXXXXXXXXXXXXXXXXXXXXXXXXXXX............\n"
"....OOXX......OOXXXXXXXXXXXXXXXXXXXXXXXXXXXX............\n"
"........XXOOXX..XXOOXXXXXXXXXXXXXXXXXXXXXXXXXXXX..XX....\n"
"........XXOOXX..XXOOXXXXXXXXXXXXXXXXXXXXXXXXXXXX..XX....\n"
"..........XXXXXXXXXXXXXXOOXXXX......XXXXXXXX........XX..\n"
"..........XXXXXXXXXXXXXXOOXXXX......XXXXXXXX........XX..\n"
"OO......OOXXXX......XXXX....XXXX......XXXXXXXXXX....XXXX\n"
"OO......OOXXXX......XXXX....XXXX......XXXXXXXXXX....XXXX\n"
"XXXXOOXXXX......OOXX............XX..XXXXXXXX....OOXXXX..\n"
"XXXXOOXXXX......OOXX............XX..XXXXXXXX....OOXXXX..\n"
"..XXXXXX....XX..........XXXX....................XXXX....\n"
"..XXXXXX....XX..........XXXX....................XXXX....\n"
;


@interface ManiacMansionHamsterIcon : IvarObject
{
    int _microwavable;
    int _cooked;

    id _path;
    BOOL _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;

    id _dragX11Dict;
}
@end
@implementation ManiacMansionHamsterIcon
- (id)init
{
    self = [super init];
    if (self) {
        _microwavable = 1;
    }
    return self;
}

- (int)preferredWidth
{
    static int w = 0;
    if (!w) {
        w = [Definitions widthForCString:hamsterPixels];
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
        h = [Definitions heightForCString:hamsterPixels];
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
    BOOL hasFocus = NO;
    {
        id windowManager = [@"windowManager" valueForKey];
        unsigned long focusInEventWindow = [[windowManager valueForKey:@"focusInEventWindow"] unsignedLongValue];
        unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
        if (focusInEventWindow && (focusInEventWindow == win)) {
            hasFocus = YES;
        }
    }

    char *pixels = hamsterPixels;
    char *palette = hamsterPalette;
    if (_cooked) {
        pixels = cookedHamsterPixels;
        palette = cookedHamsterPalette;
    }

    int w = [Definitions widthForCString:pixels];
    int h = [Definitions heightForCString:pixels];

    [bitmap drawCString:pixels palette:palette x:r.x+(r.w-w)/2 y:r.y];

    if ([_path length]) {
        [bitmap useWinSystemFont];
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

    id obj = [[menuCSV parseCSVFromString] asMenu];
    if (obj) {
        [obj setValue:self forKey:@"contextualObject"];
        [windowManager openButtonDownMenuForObject:obj x:mouseRootX y:mouseRootY w:0 h:0];
    }
}
@end

