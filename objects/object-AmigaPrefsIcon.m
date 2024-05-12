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

static char *prefsPalette =
"b #000000\n"
". #000022\n"
"X #ff8800\n"
"* #0055aa\n"
"O #ffffff\n"
;
static char *prefsPixels =
"              ...........................................................\n"
"              ...........................................................\n"
"          ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...O.\n"
"          ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...O.\n"
"      ....OOOOOOOOOOOOOOOOOOO..........OOOOOOOOOOOOOOOOOOOOOOOOOOO...OO..\n"
"      ....OOOOOOOOOOOOOOOOOOO..........OOOOOOOOOOOOOOOOOOOOOOOOOOO...OO..\n"
"   ...........................XXXXXXXX.............................OOO.O.\n"
"   ...........................XXXXXXXX.............................OOO.O.\n"
"   ..OOOOOOOOOOOOOOOOOOOOO..XXXXXXXXXXXX..OOOOOOOOOOOOOOOOOOOOOOO..OOOO..\n"
"   ..OOOOOOOOOOOOOOOOOOOOO..XXXXXXXXXXXX..OOOOOOOOOOOOOOOOOOOOOOO..OOOO..\n"
"   ..OOO...................XXXXX....XXXXX.....................OOO..OOO.O.\n"
"   ..OOO...................XXXXX....XXXXX.....................OOO..OOO.O.\n"
"   ..OOO..OOOOOOOOOOOOOOO........O..XXXXX..OOOOOOOOOOOOOOOOO..OOO..OO.O..\n"
"   ..OOO..OOOOOOOOOOOOOOO........O..XXXXX..OOOOOOOOOOOOOOOOO..OOO..OO.O..\n"
"   ..OOO..OOOOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOO..OOO..OOO.O.\n"
"   ..OOO..OOOOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOO..OOO..OOO.O.\n"
"   ..OOO..OOOOOOOOOOOOOOOOO...O..XXXXX..OO...OOOOOOOOOOOOOOO..OOO..OO.O..\n"
"   ..OOO..OOOOOOOOOOOOOOOOO...O..XXXXX..OO...OOOOOOOOOOOOOOO..OOO..OO.O..\n"
"   ..OOO..OOOOOOOOOOOOOOOO......XXXXX.......OOOOOOOOOOOOOOOO..OOO..O.O.. \n"
"   ..OOO..OOOOOOOOOOOOOOOO......XXXXX.......OOOOOOOOOOOOOOOO..OOO..O.O.. \n"
"   ..OOO..OOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOOOO..OOO..OO..  \n"
"   ..OOO..OOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOOOO..OOO..OO..  \n"
"   ..OOO..OOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOO..OOO..O..   \n"
"   ..OOO..OOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOO..OOO..O..   \n"
"   ..OOO.......................XXXXX..........................OOO....    \n"
"   ..OOO.......................XXXXX..........................OOO....    \n"
"   ..OOOOOOOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOOOOOOO...     \n"
"   ..OOOOOOOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOOOOOOO...     \n"
"   ................................................................      \n"
"   ................................................................      \n"
"                                                                         \n"
"                                                                         \n"
"                                                                         \n"
"                                                                         \n"
"                                                                         \n"
"                                                                         \n"
;

static char *openPrefsPalette =
"b #000000\n"
". #000022\n"
"X #ff8800\n"
"* #0055aa\n"
"O #ffffff\n"
;
static char *openPrefsPixels =
"              ...........................................................\n"
"              ...........................................................\n"
"          ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...O.\n"
"          ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...O.\n"
"      ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...OO..\n"
"      ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...OO..\n"
"   ................................................................OOO.O.\n"
"   ................................................................OOO.O.\n"
"   ..OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO..OOOO..\n"
"   ..OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO..OOOO..\n"
"   ..OOO......................................................OOO..OOO.O.\n"
"   ..OOO......................................................OOO..OOO.O.\n"
"   ..O...oo..o.o.o.o.o.o.........o.o.o.o.o.o.o.o.o.o.o.o.o....OOO..OO.O..\n"
"   ..O...oo..o.o.o.o.o.o.........o.o.o.o.o.o.o.o.o.o.o.o.o....OOO..OO.O..\n"
"  ....o.o.o..oo.o.o.o...XXXXXXXX....o.o.o.o.o.o.o.o.o.o.o..O..OOO..OOO.O.\n"
"  ....o.o.o..oo.o.o.o...XXXXXXXX....o.o.o.o.o.o.o.o.o.o.o..O..OOO..OOO.O.\n"
"......................XXXXXXXXXXXX........................OO..OOO..OO.O..\n"
"......................XXXXXXXXXXXX........................OO..OOO..OO.O..\n"
"..OOOOOOOOOOOOOOOOO..XXXXX....XXXXX..OOOOOOOOOOOOOOOOOOO..OO..OOO..O.O.. \n"
"..OOOOOOOOOOOOOOOOO..XXXXX....XXXXX..OOOOOOOOOOOOOOOOOOO..OO..OOO..O.O.. \n"
"..OOOOOOOOOOOOOOOOO........O..XXXXX..OOOOOOOOOOOOOOOOOOO..OO..OOO..OO..  \n"
"..OOOOOOOOOOOOOOOOO........O..XXXXX..OOOOOOOOOOOOOOOOOOO..OO..OOO..OO..  \n"
"..OOOOOOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOO..OO..OOO..O..   \n"
"..OOOOOOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOO..OO..OOO..O..   \n"
"..OOOOOOOOOOOOOOOOOOO...O..XXXXX..OO...OOOOOOOOOOOOOOOOO..OO..OOO....    \n"
"..OOOOOOOOOOOOOOOOOOO...O..XXXXX..OO...OOOOOOOOOOOOOOOOO..OO..OOO....    \n"
"..OOOOOOOOOOOOOOOOOO......XXXXX.......OOOOOOOOOOOOOOOOOO..O..OOOO...     \n"
"..OOOOOOOOOOOOOOOOOO......XXXXX.......OOOOOOOOOOOOOOOOOO..O..OOOO...     \n"
"..OOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOOOOOO...........      \n"
"..OOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOOOOOO...........      \n"
"..OOOOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOOOO...              \n"
"..OOOOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOOOO...              \n"
".........................XXXXX............................               \n"
".........................XXXXX............................               \n"
"                        .......                                          \n"
"                        .......                                          \n"
;



@interface AmigaPrefsIcon : IvarObject
{
    int _builtin;
    id _path;
    BOOL _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;
}
@end
@implementation AmigaPrefsIcon
- (int)preferredWidth
{
    static int w = 0;
    if (!w) {
        w = [Definitions widthForCString:prefsPixels];
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
        h = [Definitions heightForCString:prefsPixels];
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

    int w = [Definitions widthForCString:prefsPixels];
    int h = [Definitions heightForCString:prefsPixels];

    if (hasFocus || isSelected) {
        [bitmap drawCString:openPrefsPixels palette:openPrefsPalette x:r.x+(r.w-w)/2 y:r.y];
    } else {
        [bitmap drawCString:prefsPixels palette:prefsPalette x:r.x+(r.w-w)/2 y:r.y];
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
    id dragx11dict = [x11dict valueForKey:@"dragx11dict"];

    if (!_buttonDown && !dragx11dict) {
        return;
    }

    if (!dragx11dict) {
        int x = [x11dict intValueForKey:@"x"];
        int y = [x11dict intValueForKey:@"y"];
        int w = [x11dict intValueForKey:@"w"];
        int h = [x11dict intValueForKey:@"h"];
        id windowManager = [event valueForKey:@"windowManager"];
        id newx11dict = [windowManager openWindowForObject:self x:x y:y w:w h:h overrideRedirect:NO propertyName:"HOTDOGNOFRAME"];
        [windowManager setValue:newx11dict forKey:@"buttonDownDict"];
        [windowManager setValue:newx11dict forKey:@"menuDict"];
        [newx11dict setValue:x11dict forKey:@"dragx11dict"];
        x11dict = newx11dict;
    }

    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    int newX = mouseRootX - _buttonDownX;
    int newY = mouseRootY - _buttonDownY;

    [x11dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
    [x11dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

    [x11dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
}

- (void)handleMouseUp:(id)event
{
    _buttonDown = NO;
    id x11dict = [event valueForKey:@"x11dict"];
    id dragx11dict = [x11dict valueForKey:@"dragx11dict"];
    if (dragx11dict) {
        [x11dict setValue:nil forKey:@"dragx11dict"];

        id windowManager = [event valueForKey:@"windowManager"];
        unsigned long window = [x11dict unsignedLongValueForKey:@"window"];
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];

        unsigned long underneathWindow = [windowManager topMostWindowUnderneathWindow:window x:mouseRootX y:mouseRootY];
        if (underneathWindow) {
            id underneathx11dict = [windowManager dictForObjectWindow:underneathWindow];
            if (underneathx11dict == dragx11dict) {
                [dragx11dict setValue:@"1" forKey:@"shouldCloseWindow"];
                return;
            }

            id object = [underneathx11dict valueForKey:@"object"];
            if ([object respondsToSelector:@selector(handleDragAndDrop:)]) {
                [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
                [object handleDragAndDrop:dragx11dict];
                return;
            }
        }

        [dragx11dict setValue:@"1" forKey:@"shouldCloseWindow"];
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
            id cmd = nsarr();
            [cmd addObject:@"hotdog"];
            [cmd addObject:@"amigabuiltindir"];
            [cmd addObject:_path];
            [cmd runCommandInBackground];
        } else {
            id cmd = nsarr();
            [cmd addObject:@"hotdog"];
            [cmd addObject:@"amigadir"];
            [cmd addObject:_path];
            [cmd runCommandInBackground];
        }
    }
}
- (void)handleDragAndDrop:(id)obj
{
//    [nsfmt(@"%@ dropped onto %@", obj, self) showAlert];
}
@end

