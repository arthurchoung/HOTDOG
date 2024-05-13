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

static id menuCSV =
@"displayName,messageForClick\n"
@"\"Open Trash\",\"handleOpen\"\n"
;

static char *trashPalette =
"b #000000\n"
". #ffffff\n"
;

static char *selectedTrashPalette =
". #000000\n"
"b #ffffff\n"
;

static char *trashPixels =
"                                  bbbbb                                 \n"
"                             bbbbbb   bbbbbb                            \n"
"                           bbb...bb   bb...bbb                          \n"
"                          b...................b                         \n"
"                          bbbb.............bbbb                         \n"
"                           b.bbbbbbbbbbbbbbb.b                          \n"
"                           b.................b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b..b...b.b..b                          \n"
"                           b.b...b..bb.bb.b..b                          \n"
"                           b.b...b...bbb..b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.b...b....b...b..b                          \n"
"                           b.bb..b....b..bb..b                          \n"
"                           bb....bb..bb.....bb                          \n"
"                            bbb...........bbb                           \n"
"                              bbbbbbbbbbbbb                             \n"
"                                                                        \n"
"........................................................................\n"
".....................bbbbb.bbbb...bbb...bbbb.b...b......................\n"
".......................b...b...b.b...b.b.....b...b......................\n"
".......................b...bbbb..bbbbb..bbb..bbbbb......................\n"
".......................b...b.b...b...b.....b.b...b......................\n"
".......................b...b..bb.b...b.bbbb..b...b......................\n"
"........................................................................\n"
"........................................................................\n"
;

@implementation Definitions(INMfewlfmklsdmvklsjdklfjklsdffjdkslmfklxcmvklcxkl)
+ (id)AtariSTTrashIcon
{
    id obj = [@"AtariSTTrashIcon" asInstance];
    return obj;
}
@end


@interface AtariSTTrashIcon : IvarObject
{
    int _builtin;
    id _path;
    int _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;

    id _dragX11Dict;
}
@end
@implementation AtariSTTrashIcon

- (int)preferredWidth
{
    static int w = 0;
    if (!w) {
        w = [Definitions widthForCString:trashPixels];
    }
    return w;
}
- (int)preferredHeight
{
    static int h = 0;
    if (!h) {
        h = [Definitions heightForCString:trashPixels];
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
    if (hasFocus || isSelected) {
        [bitmap drawCString:trashPixels palette:selectedTrashPalette x:r.x y:r.y];
    } else {
        [bitmap drawCString:trashPixels palette:trashPalette x:r.x y:r.y];
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
                    [nsfmt(@"Dropped onto window %lu", underneathWindow) showAlert];
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

    id obj = [[menuCSV parseCSVFromString] asMenu];
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
    [Definitions openAtariSTDirForPath:[Definitions homeDir:@"Trash"]];
}

- (void)handleDragAndDrop:(id)obj
{
    [nsfmt(@"%@ dropped onto %@", obj, self) showAlert];
}

@end

