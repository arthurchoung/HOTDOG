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

static id menuCSV =
@"displayName,messageForClick\n"
@"\"Open Trash\",\"handleOpen\"\n"
@",\n"
@"Quit,\"exit:0\"\n"
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
+ (id)AmigaTrash
{
    id obj = [@"AmigaTrash" asInstance];
    return obj;
}
@end


@interface AmigaTrash : IvarObject
{
    int _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;
}
@end
@implementation AmigaTrash
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
    BOOL hasFocus = NO;
    {
        id windowManager = [@"windowManager" valueForKey];
        unsigned long focusInEventWindow = [[windowManager valueForKey:@"focusInEventWindow"] unsignedLongValue];
        unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
        if (focusInEventWindow && (focusInEventWindow == win)) {
            hasFocus = YES;
        }
    }

    [bitmap setColor:@"black"];
    [bitmap fillRect:r];
    if (hasFocus) {
        [bitmap drawCString:openTrashPixels palette:openTrashPalette x:r.x y:r.y];
    } else {
        [bitmap drawCString:trashPixels palette:trashPalette x:r.x y:r.y];
    }

    id windowManager = [@"windowManager" valueForKey];
    unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
    if (hasFocus) {
        [windowManager addMaskToWindow:win cString:openTrashPixels c:' '];
    } else {
        [windowManager addMaskToWindow:win cString:trashPixels c:' '];
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
    id cmd = nsarr();
    [cmd addObject:@"hotdog"];
    [cmd addObject:@"amigadir"];
    [cmd addObject:[Definitions homeDir:@"Trash"]];
    [cmd runCommandInBackground];
}


@end

