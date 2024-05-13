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
". #000022\n"
"X #FF8800\n"
"o #0055AA\n"
"O #FFFFFF\n"
;

static char *trashPixels =
"                                                              \n"
"                                                              \n"
"                                                              \n"
"                                                              \n"
"                                                              \n"
"                                                              \n"
"                                                              \n"
"                                                              \n"
"                               ................               \n"
"                               ................               \n"
"                              ...            ...              \n"
"                              ...            ...              \n"
"                   ......................................     \n"
"                   ......................................     \n"
"                 ..X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXX..   \n"
"                 ..X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXX..   \n"
"                ..X.X.X.X.X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXX..  \n"
"                ..X.X.X.X.X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXX..  \n"
"                ............................................  \n"
"                ............................................  \n"
"                 ..X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXX..   \n"
"                 ..X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXX..   \n"
"                 ...X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX..   \n"
"                 ...X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX..   \n"
"                  ...X......XXXXXXX.......XXXXXX.....XXX..    \n"
"                  ...X......XXXXXXX.......XXXXXX.....XXX..    \n"
"                  ..X...X.X...XXX...X.X.X..XXX..X.X...XX..    \n"
"                  ..X...X.X...XXX...X.X.X..XXX..X.X...XX..    \n"
"                  ...X...XXX..XXX..X.XXXX..XXX...XXX..XX..    \n"
"                  ...X...XXX..XXX..X.XXXX..XXX...XXX..XX..    \n"
"                  ..X...X.XX..XXX...X.XXX..XXX..X.XX..XX..    \n"
"                  ..X...X.XX..XXX...X.XXX..XXX..X.XX..XX..    \n"
"                   ..X...XXX..XXX..X.XXXX..XXX...XXX..X..     \n"
"                   ..X...XXX..XXX..X.XXXX..XXX...XXX..X..     \n"
"                   ...X...XXX..XX...X.XXX..XX...XXX..XX..     \n"
"                   ...X...XXX..XX...X.XXX..XX...XXX..XX..     \n"
"                   ..X...X.XX..XX..X.XXXX..XX..X.XX..XX..     \n"
"                   ..X...X.XX..XX..X.XXXX..XX..X.XX..XX..     \n"
"                   ...X...XXX..XXX..X.XX..XXX...XXX..XX..     \n"
"                   ...X...XXX..XXX..X.XX..XXX...XXX..XX..     \n"
"                    ...X...XX..XXX...XXX..XXX..XXX..XX..      \n"
"                    ...X...XX..XXX...XXX..XXX..XXX..XX..      \n"
"                    ..X...X.X..XXX..X.XX..XXX...XX..XX..      \n"
"                    ..X...X.X..XXX..X.XX..XXX...XX..XX..      \n"
"                    ...X...XXX..XX...XXX..XX...XXX..XX..      \n"
"                    ...X...XXX..XX...XXX..XX...XXX..XX..      \n"
"                    ..X.X...XX..XX..X.XX..XX..X.X..XXX..      \n"
"                    ..X.X...XX..XX..X.XX..XX..X.X..XXX..      \n"
"                .......X...X.X..XXX..XX..XXX...XX..XX..       \n"
"                .......X...X.X..XXX..XX..XXX...XX..XX..       \n"
"       .................X...X...XXX...X..XXX..X...XXX..       \n"
"       .................X...X...XXX...X..XXX..X...XXX..       \n"
"   ....................X.X.....X.X.X....XXXXX....XXXX..       \n"
"   ....................X.X.....X.X.X....XXXXX....XXXX..       \n"
"     .....................X.X.X.X.X.XXXXXXXXXXXXXXX...        \n"
"     .....................X.X.X.X.X.XXXXXXXXXXXXXXX...        \n"
"          ..........................................          \n"
"          ..........................................          \n"
"                    ....................                      \n"
"                    ....................                      \n"
"                                                              \n"
"                                                              \n"
"OOOOOO                         OOO                            \n"
"OOOOOO                         OOO                            \n"
"O OO O                          OO                            \n"
"O OO O                          OO                            \n"
"  OO   OOO OO    OOOO    OOOOO  OO OO    OOOO    OOOO   OOOOO \n"
"  OO   OOO OO    OOOO    OOOOO  OO OO    OOOO    OOOO   OOOOO \n"
"  OO    OOO OO      OO  OO      OOO OO  OO  OO      OO  OO  OO\n"
"  OO    OOO OO      OO  OO      OOO OO  OO  OO      OO  OO  OO\n"
"  OO    OO  OO    OOOO   OOOO   OO  OO  OO        OOOO  OO  OO\n"
"  OO    OO  OO    OOOO   OOOO   OO  OO  OO        OOOO  OO  OO\n"
"  OO    OO      OO  OO      OO  OO  OO  OO  OO  OO  OO  OO  OO\n"
"  OO    OO      OO  OO      OO  OO  OO  OO  OO  OO  OO  OO  OO\n"
" OOOO  OOOO      OOO OO OOOOO  OOO  OO   OOOO    OOO OO OO  OO\n"
" OOOO  OOOO      OOO OO OOOOO  OOO  OO   OOOO    OOO OO OO  OO\n"
;

static char *openTrashPalette =
"b #000000\n"
". #000022\n"
"X #FF8800\n"
"o #0055AA\n"
"O #FFFFFF\n"
;

static char *openTrashPixels =
"                             ..................               \n"
"                             ..................               \n"
"                      .......XXXXXXXXXXXXXXXXXX.......        \n"
"                      .......XXXXXXXXXXXXXXXXXX.......        \n"
"                 .....XXXXXXXX.................XXXXXXX.....   \n"
"                 .....XXXXXXXX.................XXXXXXX.....   \n"
"                ..XXXX........X.X.X.XXXXX.X.X.X......XXXXX..  \n"
"                ..XXXX........X.X.X.XXXXX.X.X.X......XXXXX..  \n"
"               ..XX....X.X.X.X.X.XXXX.X.XXXX.X.X.X.X.....XX.. \n"
"               ..XX....X.X.X.X.X.XXXX.X.XXXX.X.X.X.X.....XX.. \n"
"                ..X..XX.X.X.X.X.X.X.XXXXX.X.X.X.X.X.XXX..X..  \n"
"                ..X..XX.X.X.X.X.X.X.XXXXX.X.X.X.X.X.XXX..X..  \n"
"                 ......XXXXXXX.X.X.X.X.X.X.X.X.XXXXXX......   \n"
"                 ......XXXXXXX.X.X.X.X.X.X.X.X.XXXXXX......   \n"
"                     .........XXXXXXXXXXXXXXXXX........       \n"
"                     .........XXXXXXXXXXXXXXXXX........       \n"
"                             ...................              \n"
"                             ...................              \n"
"                 ..........................................   \n"
"                 ..........................................   \n"
"                 ..X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXX..   \n"
"                 ..X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXX..   \n"
"                 ...X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX..   \n"
"                 ...X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX..   \n"
"                  ...X......XXXXXXX.......XXXXXX.....XXX..    \n"
"                  ...X......XXXXXXX.......XXXXXX.....XXX..    \n"
"                  ..X...X.X...XXX...X.X.X..XXX..X.X...XX..    \n"
"                  ..X...X.X...XXX...X.X.X..XXX..X.X...XX..    \n"
"                  ...X...XXX..XXX..X.XXXX..XXX...XXX..XX..    \n"
"                  ...X...XXX..XXX..X.XXXX..XXX...XXX..XX..    \n"
"                  ..X...X.XX..XXX...X.XXX..XXX..X.XX..XX..    \n"
"                  ..X...X.XX..XXX...X.XXX..XXX..X.XX..XX..    \n"
"                   ..X...XXX..XXX..X.XXXX..XXX...XXX..X..     \n"
"                   ..X...XXX..XXX..X.XXXX..XXX...XXX..X..     \n"
"                   ...X...XXX..XX...X.XXX..XX...XXX..XX..     \n"
"                   ...X...XXX..XX...X.XXX..XX...XXX..XX..     \n"
"                   ..X...X.XX..XX..X.XXXX..XX..X.XX..XX..     \n"
"                   ..X...X.XX..XX..X.XXXX..XX..X.XX..XX..     \n"
"                   ...X...XXX..XXX..X.XX..XXX...XXX..XX..     \n"
"                   ...X...XXX..XXX..X.XX..XXX...XXX..XX..     \n"
"                    ...X...XX..XXX...XXX..XXX..XXX..XX..      \n"
"                    ...X...XX..XXX...XXX..XXX..XXX..XX..      \n"
"                    ..X...X.X..XXX..X.XX..XXX...XX..XX..      \n"
"                    ..X...X.X..XXX..X.XX..XXX...XX..XX..      \n"
"                    ...X...XXX..XX...XXX..XX...XXX..XX..      \n"
"                    ...X...XXX..XX...XXX..XX...XXX..XX..      \n"
"                    ..X.X...XX..XX..X.XX..XX..X.X..XXX..      \n"
"                    ..X.X...XX..XX..X.XX..XX..X.X..XXX..      \n"
"                .......X...X.X..XXX..XX..XXX...XX..XX..       \n"
"                .......X...X.X..XXX..XX..XXX...XX..XX..       \n"
"       .................X...X...XXX...X..XXX..X...XXX..       \n"
"       .................X...X...XXX...X..XXX..X...XXX..       \n"
"   ....................X.X.....X.X.X....XXXXX....XXXX..       \n"
"   ....................X.X.....X.X.X....XXXXX....XXXX..       \n"
"     .....................X.X.X.X.X.XXXXXXXXXXXXXXX...        \n"
"     .....................X.X.X.X.X.XXXXXXXXXXXXXXX...        \n"
"          ..........................................          \n"
"          ..........................................          \n"
"                    ....................                      \n"
"                    ....................                      \n"
"                                                              \n"
"                                                              \n"
"OOOOOO                         OOO                            \n"
"OOOOOO                         OOO                            \n"
"O OO O                          OO                            \n"
"O OO O                          OO                            \n"
"  OO   OOO OO    OOOO    OOOOO  OO OO    OOOO    OOOO   OOOOO \n"
"  OO   OOO OO    OOOO    OOOOO  OO OO    OOOO    OOOO   OOOOO \n"
"  OO    OOO OO      OO  OO      OOO OO  OO  OO      OO  OO  OO\n"
"  OO    OOO OO      OO  OO      OOO OO  OO  OO      OO  OO  OO\n"
"  OO    OO  OO    OOOO   OOOO   OO  OO  OO        OOOO  OO  OO\n"
"  OO    OO  OO    OOOO   OOOO   OO  OO  OO        OOOO  OO  OO\n"
"  OO    OO      OO  OO      OO  OO  OO  OO  OO  OO  OO  OO  OO\n"
"  OO    OO      OO  OO      OO  OO  OO  OO  OO  OO  OO  OO  OO\n"
" OOOO  OOOO      OOO OO OOOOO  OOO  OO   OOOO    OOO OO OO  OO\n"
" OOOO  OOOO      OOO OO OOOOO  OOO  OO   OOOO    OOO OO OO  OO\n"
;

@implementation Definitions(INMfewlfmklsdmvklsjdklfjklsdfjfksdjfkj)
+ (id)AmigaTrashIcon
{
    id obj = [@"AmigaTrashIcon" asInstance];
    return obj;
}
@end


@interface AmigaTrashIcon : IvarObject
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
@implementation AmigaTrashIcon

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
        [bitmap drawCString:openTrashPixels palette:openTrashPalette x:r.x y:r.y];
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
    [Definitions openAmigaDirForPath:[Definitions homeDir:@"Trash"]];
}

- (void)handleDragAndDrop:(id)obj
{
//    [nsfmt(@"%@ dropped onto %@", obj, self) showAlert];
}

@end

