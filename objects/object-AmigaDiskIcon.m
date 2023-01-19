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

//int textWidth = [Definitions bitmapWidthForText:@"X"]*MAX_CHARS_TO_DRAW;
/*
        id filePath = [elt valueForKey:@"filePath"];
        if ([filePath length] > MAX_CHARS_TO_DRAW) {
            id a = [filePath stringToIndex:(MAX_CHARS_TO_DRAW/2)-1];
            id b = [filePath stringFromIndex:(MAX_CHARS_TO_DRAW/2)+1];
            filePath = nsfmt(@"%@..%@", a, b);
        }
        [bitmap drawBitmapText:filePath centeredAtX:x+w/2 y:y+h-8];
*/

static char *diskPalette =
"b #000000\n"
". #000022\n"
"X #FF8800\n"
"o #0055AA\n"
"O #FFFFFF\n"
;
static char *selectedDiskPalette =
"b #000000\n"
"O #000022\n"
"o #FF8800\n"
"X #0055AA\n"
". #FFFFFF\n"
;

static char *diskPixels =
".........XXXXXXXXXXXXXXXXX.......  \n"
".........XXXXXXXXXXXXXXXXX.......  \n"
".........XXXXXXXXXX....XXX........ \n"
".........XXXXXXXXXX....XXX........ \n"
".........XXXXXXXXXX....XXX.........\n"
".........XXXXXXXXXX....XXX.........\n"
".........XXXXXXXXXX....XXX.........\n"
".........XXXXXXXXXX....XXX.........\n"
".........XXXXXXXXXXXXXXXXX.........\n"
".........XXXXXXXXXXXXXXXXX.........\n"
"...................................\n"
"...................................\n"
"...................................\n"
"...................................\n"
"......OOOOOOO.X.X.X.O.o.OOOO.......\n"
"......OOOOOOO.X.X.X.O.o.OOOO.......\n"
"......OOOOOO.X.O.X.o.O.o.OOOO......\n"
"......OOOOOO.X.O.X.o.O.o.OOOO......\n"
"......OOOOO.X.O.X.O.o.O.o.OOO......\n"
"......OOOOO.X.O.X.O.o.O.o.OOO......\n"
"......OOOO.X.O.X.OOO.o.O.o.OO......\n"
"......OOOO.X.O.X.OOO.o.O.o.OO......\n"
"......OOO.X.O.X.OOOOOOOOOOOOO......\n"
"......OOO.X.O.X.OOOOOOOOOOOOO......\n"
"......OO.X.O.X.OOOOOOOOOOOOOO......\n"
"......OO.X.O.X.OOOOOOOOOOOOOO......\n"
"..oo..O.X.O.X.OOOOOOOOOOOOOOO......\n"
"..oo..O.X.O.X.OOOOOOOOOOOOOOO......\n"
"......OOOOOOOOOOOOOOOOOOOOOOO......\n"
"......OOOOOOOOOOOOOOOOOOOOOOO......\n"
;



@interface AmigaDiskIcon : IvarObject
{
    int _builtin;
    id _path;
    id _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;

    id _dragX11Dict;
}
@end
@implementation AmigaDiskIcon
- (int)preferredWidth
{
    static int w = 0;
    if (!w) {
        w = [Definitions widthForCString:diskPixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useTopazFont];
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
        h = [Definitions heightForCString:diskPixels];
        h += 16;
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

    int w = [Definitions widthForCString:diskPixels];
    int h = [Definitions heightForCString:diskPixels];

    if (hasFocus || isSelected) {
        [bitmap drawCString:diskPixels palette:selectedDiskPalette x:r.x+(r.w-w)/2 y:r.y];
    } else {
        [bitmap drawCString:diskPixels palette:diskPalette x:r.x+(r.w-w)/2 y:r.y];
    }
    if ([_path length]) {
        [bitmap setColor:@"white"];
        [bitmap useTopazFont];
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

    if (![x11dict intValueForKey:@"isSelected"]) {
        id objectWindows = [windowManager valueForKey:@"objectWindows"];
        for (int i=0; i<[objectWindows count]; i++) {
            id elt = [objectWindows nth:i];
            [elt setValue:nil forKey:@"isSelected"];
            [elt setValue:@"1" forKey:@"needsRedraw"];
        }
        [x11dict setValue:@"1" forKey:@"isSelected"];
        [x11dict setValue:@"1" forKey:@"needsRedraw"];
    }

    struct timeval tv;
    gettimeofday(&tv, NULL);
    id timestamp = nsfmt(@"%ld.%06ld", tv.tv_sec, tv.tv_usec);
    if (_buttonDownTimestamp) {
        if ([timestamp doubleValue]-[_buttonDownTimestamp doubleValue] <= 0.3) {
            _buttonDown = NO;
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

        unsigned long underneathWindow = [windowManager topMostWindowUnderneathWindow:window x:mouseRootX y:mouseRootY];
        if (underneathWindow) {
            id underneathx11dict = [windowManager dictForObjectWindow:underneathWindow];
            if (underneathx11dict == x11dict) {
            } else {
                id object = [underneathx11dict valueForKey:@"object"];
                if ([object respondsToSelector:@selector(handleDragAndDrop:)]) {
                    [object handleDragAndDrop:_dragX11Dict];
                } else {
//                    [nsfmt(@"Dropped onto window %lu", underneathWindow) showAlert];
                }
            }
        } else {
            int oldX = [x11dict intValueForKey:@"x"];
            int oldY = [x11dict intValueForKey:@"y"];
            int newX = mouseRootX - _buttonDownX;
            int newY = mouseRootY - _buttonDownY;
            int deltaX = newX - oldX;
            int deltaY = newY - oldY;
            id objectWindows = [windowManager valueForKey:@"objectWindows"];
            for (int i=0; i<[objectWindows count]; i++) {
                id elt = [objectWindows nth:i];
                if (![elt intValueForKey:@"isSelected"]) {
                    continue;
                }
                newX = [elt intValueForKey:@"x"] + deltaX;
                newY = [elt intValueForKey:@"y"] + deltaY;
                [elt setValue:nsfmt(@"%d", newX) forKey:@"x"];
                [elt setValue:nsfmt(@"%d", newY) forKey:@"y"];
                [elt setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
            }
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
- (void)handleDoubleClick
{
    [self handleOpen];
}
- (void)handleOpen
{
    if ([_path length]) {
        if (_builtin) {
            [Definitions openAmigaBuiltInDirForPath:_path];
        } else {
            [Definitions openAmigaDirForPath:_path];
        }
    }
}
- (void)handleDragAndDrop:(id)obj
{
//    [nsfmt(@"%@ dropped onto %@", obj, self) showAlert];
}
@end

